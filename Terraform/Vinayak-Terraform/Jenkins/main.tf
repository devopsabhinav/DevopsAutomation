//------------------------------------------------------------------------------------------
#Fetch EKS OIDC Data
data "aws_eks_cluster" "oidc_url" {
  name = var.cluster_name
}

output "oidc_provider_url" {
  value = data.aws_eks_cluster.oidc_url.identity.0.oidc.0.issuer
}

data "aws_eks_cluster" "oidc_arn" {
  name = var.cluster_name
}

data "aws_iam_openid_connect_provider" "my_provider" {
  url = data.aws_eks_cluster.oidc_arn.identity.0.oidc.0.issuer
}

output "eks_oidc_provider_arn" {
  value = data.aws_iam_openid_connect_provider.my_provider.arn
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "${var.project_name}-VPC"
  }
}

# output "vpc_cidr_block" {
#   value = "${data.aws_vpc.vpc.cidr_block}"
# }

# output "vpc_id" {
#   value = "${data.aws_vpc.vpc.id}"
# }

data "aws_subnet" "subnet_private_1a" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-PrivateSubnet-1a"]
  }
}
# output "subnet_private_1a" {
#   value = data.aws_subnet.subnet_private_1a.id
# }

data "aws_subnet" "subnet_private_1b" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-PrivateSubnet-1b"]
  }
}
# output "subnet_private_1b" {
#   value = data.aws_subnet.subnet_private_1b.id
# }

data "aws_subnet" "subnet_private_1c" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-PrivateSubnet-1c"]
  }
}
# output "subnet_private_1c" {
#   value = data.aws_subnet.subnet_private_1c.id
# }

//------------------------------------------------------------------------------------------
#Adding EFS Access Policy to NodeGroup Role
resource "aws_iam_role_policy_attachment" "attach_route53_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
  role       = "${var.project_name}-eksNodeGroupRole"
}

//------------------------------------------------------------------------------------------
#create EFS_CSI_Driver Policy
resource "aws_iam_policy" "efs_driver_policy" {
  name        = "${var.project_name}-AmazonEKS_EFS_CSI_Driver_Policy"
  path        = "/"
  description = "Policy for AmazonEKS_EFS_CSI_Driver"
  tags = {
    Name = "${var.project_name}-AmazonEKS_EFS_CSI_Driver_Policy"
  }
  policy = file("./efs_driver_policy.json")
}

//------------------------------------------------------------------------------------------
#Create EFS_CSI_DriverRole
resource "aws_iam_role" "ebs_csi" {
  name = "${var.project_name}-AmazonEKS_EFS_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_policy.json
  tags = {
    Name = "${var.project_name}-AmazonEKS_EFS_CSI_DriverRole"
  }
}
data "aws_iam_policy_document" "ebs_csi_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.oidc_url.identity.0.oidc.0.issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.my_provider.arn]
      type        = "Federated"
    }
  }
}
//------------------------------------------------------------------------------------------
#Attach EFS_CSI_Driver Policy to Above Role
resource "aws_iam_role_policy_attachment" "attach_ebs_csi_policy" {
  role       = aws_iam_role.ebs_csi.name
  policy_arn = aws_iam_policy.efs_driver_policy.arn

  depends_on = [
    aws_iam_role.ebs_csi,
    aws_iam_policy.efs_driver_policy
  ]
}
//------------------------------------------------------------------------------------------
#Create Service Account for EFS-CSI-Controller-sa

resource "kubernetes_service_account" "efs_csi_controller_sa" {
  metadata {
    name      = "efs-csi-controller-sa"
    namespace = "kube-system"

    labels = {
      "app.kubernetes.io/name" = "aws-efs-csi-driver"
    }

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.ebs_csi.arn
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.attach_ebs_csi_policy
  ]
}
//------------------------------------------------------------------------------------------
#EFS file system

resource "aws_efs_file_system" "jenkins_fs" {
  creation_token = "jenkins_fs"
  encrypted = true
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"

  tags = {
    Name = "${var.project_name}-EFS"
  }
  depends_on = [
    kubernetes_service_account.efs_csi_controller_sa
  ]
}

//------------------------------------------------------------------------------------------
#EFS access point

resource "aws_efs_access_point" "jenkins_ap" {
  file_system_id = aws_efs_file_system.jenkins_fs.id
  posix_user {
    uid = 1000 
    gid = 1000
    }
  root_directory {
    path = "/jenkins"
    creation_info {
      owner_uid = 1000
      owner_gid = 1000
      permissions = 777
      }
  }
  depends_on = [
    aws_efs_file_system.jenkins_fs
  ]  
}

//------------------------------------------------------------------------------------------
#Security group

resource "aws_security_group" "efs_mount_sg" {
  name        = "efs_mount_sg"
  description = "Amazon EFS for EKS, SG for mount target"
  vpc_id      = data.aws_vpc.vpc.id
  ingress {
    description      = "TLS from VPC"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    # cidr_blocks      = [aws_vpc.jenkins_vpc.cidr_block]
    cidr_blocks      = [data.aws_vpc.vpc.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.jenkins_vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-efs-sg"
  }
  depends_on = [
    aws_efs_access_point.jenkins_ap
  ]
}

//------------------------------------------------------------------------------------------
#Mount Target

resource "aws_efs_mount_target" "jenkins_mt1" {
  # count = 2
  file_system_id = aws_efs_file_system.jenkins_fs.id
  subnet_id = data.aws_subnet.subnet_private_1a.id
  security_groups = [aws_security_group.efs_mount_sg.id]
  
  depends_on = [
    aws_security_group.efs_mount_sg
  ]  
}

resource "aws_efs_mount_target" "jenkins_mt2" {
  # count = 2
  file_system_id = aws_efs_file_system.jenkins_fs.id
  subnet_id = data.aws_subnet.subnet_private_1b.id
  security_groups = [aws_security_group.efs_mount_sg.id]

  depends_on = [
    aws_security_group.efs_mount_sg
  ] 
}

resource "aws_efs_mount_target" "jenkins_mt3" {
  # count = 2
  file_system_id = aws_efs_file_system.jenkins_fs.id
  subnet_id = data.aws_subnet.subnet_private_1c.id
  security_groups = [aws_security_group.efs_mount_sg.id]

  depends_on = [
    aws_security_group.efs_mount_sg
  ]   
}

//------------------------------------------------------------------------------------------
#Creating PV for Jenkins

resource "helm_release" "Persistent-Volume" {
  name = "persistent-volume"
  chart = "./Persistent-Volume"
  namespace  = "jenkins"
  create_namespace = true

  depends_on = [
    aws_efs_mount_target.jenkins_mt1
  ]

  set {
    name = "volumehandle"
    value = "${aws_efs_file_system.jenkins_fs.id}::${aws_efs_access_point.jenkins_ap.id}"
  }
}

//------------------------------------------------------------------------------------------
#Installing EFS-CSI-Driver in Cluster

resource "helm_release" "aws-efs-csi-driver" {
  name       = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"
  depends_on = [
    kubernetes_service_account.efs_csi_controller_sa,
    helm_release.Persistent-Volume
  ]

  set {
    name  = "controller.serviceAccount.name"
    value = "efs-csi-controller-sa"
  }
  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }  
  set {
    name  = "image.repository"
    value = format("602401143452.dkr.ecr.%s.amazonaws.com/eks/aws-efs-csi-driver", var.region)
  }
}

//------------------------------------------------------------------------------------------
#Installing jenkins in Cluster

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"
  namespace  = "jenkins"
  depends_on = [
    helm_release.aws-efs-csi-driver,
    helm_release.Persistent-Volume
  ]

  values = [
    file("./values.yaml")
  ]
}