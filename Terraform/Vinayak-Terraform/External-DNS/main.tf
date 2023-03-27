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
#create External-DNS Policy
resource "aws_iam_policy" "external_dns_policy" {
  name        = "${var.project_name}-AWSExternalDNSPolicy"
  path        = "/"
  description = "Policy for ExternalDNS"
  tags = {
    Name = "${var.project_name}-AWSExternalDNSPolicy"
  }
  policy = file("./external_dnspolicy.json")
}

//---
#External-DNS Role
resource "aws_iam_role" "eks_external_dns_role" {
  name               = "${var.project_name}-AmazonEKSExternalDNSRole"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_external_dns_iam_role_policy.json
  tags = {
    "Name" = "${var.project_name}-AmazonEKSExternalDNSRole"
  }
}

data "aws_iam_policy_document" "eks_cluster_external_dns_iam_role_policy" {
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
      values   = ["system:serviceaccount:kube-system:external-dns"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.my_provider.arn]
      type        = "Federated"
    }
  }
}

//------------------------------------------------------------------------------------------
#Attach External-DNS Policy to Above Role
resource "aws_iam_role_policy_attachment" "attach_external_dns_policy" {
  role       = aws_iam_role.eks_external_dns_role.name
  policy_arn = aws_iam_policy.external_dns_policy.arn

  depends_on = [
    aws_iam_role.eks_external_dns_role,
    aws_iam_policy.external_dns_policy
  ]
}

//------------------------------------------------------------------------------------------
#Create Service Account for External-DNS
resource "kubernetes_service_account" "external-dns" {
  metadata {
    name      = "external-dns"
    namespace = "kube-system"

    labels = {
      "app.kubernetes.io/name" = "external-dns"
    }

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_external_dns_role.arn
    }
  }
}

//------------------------------------------------------------------------------------------
#Deploying External-DNS in cluster

resource "helm_release" "external_dns" {
  name = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = "kube-system"
  depends_on = [
    kubernetes_service_account.external-dns
  ]

  set {
    name  = "serviceAccount.create"
    value = "false"
  }
  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }
  set {
    name  = "serviceAccount.create"
    value = "false"
  }  
  set {
    name  = "policy"
    value = "sync"
  }
}