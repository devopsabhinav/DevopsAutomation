terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.59.0"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "me"
}
//--------

data "aws_eks_cluster" "cluster_host" {
  name = var.cluster_name
}

# output "kubernetes_host" {
#   value = data.aws_eks_cluster.cluster_host.endpoint
# }

data "aws_eks_cluster" "cluster_cert" {
  name = var.cluster_name
}

//------

# output "cluster_ca_certificate" {
#   value = base64decode(data.aws_eks_cluster.cluster_cert.certificate_authority.0.data)
# }

//-----

data "aws_eks_cluster" "my_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "my_cluster_auth" {
  name = data.aws_eks_cluster.my_cluster.name
}

# output "token" {
#   value = data.aws_eks_cluster_auth.my_cluster_auth.token
#   sensitive = true
# }
//---

# terraform {
#   required_providers {
#     kubernetes = {
#       source = "hashicorp/kubernetes"
#       version = ">=2.18.1"
#     }
#   }
# }

provider "kubernetes" {
  
  # config_context_cluster = var.cluster_name
  host                   = data.aws_eks_cluster.cluster_host.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_cert.certificate_authority.0.data)

    exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }

  token = data.aws_eks_cluster_auth.my_cluster_auth.token
}

//----

# terraform {
#   required_providers {
#     helm = {
#       source = "hashicorp/helm"
#       version = ">=2.9.0"
#     }
#   }
# }

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster_host.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_cert.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
    token = data.aws_eks_cluster_auth.my_cluster_auth.token
  }
}
