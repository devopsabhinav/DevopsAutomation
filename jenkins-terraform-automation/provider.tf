provider "aws" {
  region = var.region_name
  # shared_credentials_file = "~/.aws/credentials"
  # profile                 = "development"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kubernetes_config_context
}