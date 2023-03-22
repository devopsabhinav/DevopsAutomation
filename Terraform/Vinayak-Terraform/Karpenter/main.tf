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
//---
#create karpenter controller Policy
resource "aws_iam_policy" "karpenter_controller_policy" {
  name        = "${var.project_name}-AWSKarpenterControllerPolicy"
  path        = "/"
  description = "Policy for Karpenter Controller"
  tags = {
    Name = "${var.project_name}-AWSKarpenterControllerPolicy"
  }
  policy = file("./karpentercontrollepolicy.json")
}

//---
#Karpenter Controller Role
resource "aws_iam_role" "karpenter_controller_role" {
  name               = "${var.project_name}-AmazonEKSKarpenterControllerRole"
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_role_policy.json
  tags = {
    "Name" = "${var.project_name}-AmazonEKSKarpenterControllerRole"
  }
}

data "aws_iam_policy_document" "karpenter_controller_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.oidc_url.identity.0.oidc.0.issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.oidc_url.identity.0.oidc.0.issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:karpenter:karpenter"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.my_provider.arn]
      type        = "Federated"
    }
  }
}
//------------------------------------------------------------------------------------------
#Attach karpenter CONTROLLER Policy to Above Role
resource "aws_iam_role_policy_attachment" "attach_karpenter_controller_policy" {
  role       = aws_iam_role.karpenter_controller_role.name
  policy_arn = aws_iam_policy.karpenter_controller_policy.arn

  depends_on = [
    aws_iam_role.karpenter_controller_role,
    aws_iam_policy.karpenter_controller_policy
  ]
}

//---
#Installing Karpenter in Cluster

resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "v0.26.1"
  namespace  = "karpenter"
  create_namespace = true
  
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter_controller_role.arn
  }

  set {
    name  = "settings.aws.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = data.aws_eks_cluster.cluster_host.endpoint
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = var.instance_profile
  }

}

# resource "kubernetes_manifest" "example" {
#   yaml_body = "${file("deployment.yaml")}"
# }