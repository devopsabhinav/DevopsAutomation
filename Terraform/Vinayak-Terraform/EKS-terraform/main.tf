
# 1 - Creating VPC
module "vpc" {
  source         = "./modules/vpc"
  project_name   = var.project_name
  vpc_cidr_block = var.vpc_cidr_block
}

# 2 - Creating EIP for NAT
module "eip" {
  source       = "./modules/eip"
  project_name = var.project_name

  depends_on = [
    module.vpc
  ]
}

# 3 - Creating Subnets
module "subnets" {
  source       = "./modules/subnets"
  aws_vpc_id   = module.vpc.output_vpc_id
  project_name = var.project_name

  cidr_block_public_1a = var.cidr_block_public_1a
  cidr_block_public_1b = var.cidr_block_public_1b
  cidr_block_public_1c = var.cidr_block_public_1c

  cidr_block_private_1a = var.cidr_block_private_1a
  cidr_block_private_1b = var.cidr_block_private_1b
  cidr_block_private_1c = var.cidr_block_private_1c

  az_1a = var.az_1a
  az_1b = var.az_1b
  az_1c = var.az_1c

  depends_on = [
    module.eip
  ]
}

# 4 - Creating IGW
module "igw" {
  source       = "./modules/igw"
  aws_vpc_id   = module.vpc.output_vpc_id
  project_name = var.project_name

  depends_on = [
    module.subnets
  ]
}

# 5 - Creating NGW
module "ngw" {
  source              = "./modules/ngw"
  eip_nat_id          = module.eip.output_eip_nat_id
  subnet_public_1a_id = module.subnets.output_subnet_public_1a_id
  project_name        = var.project_name

  depends_on = [
    module.igw
  ]
}

# 6 - Create Route Tables
module "route_table" {
  source       = "./modules/route_table"
  igw_id       = module.igw.output_vpc_igw_id
  ngw_id       = module.ngw.output_ngw_id
  aws_vpc_id   = module.vpc.output_vpc_id
  project_name = var.project_name

  subnet_public_1a_id = module.subnets.output_subnet_public_1a_id
  subnet_public_1b_id = module.subnets.output_subnet_public_1b_id
  subnet_public_1c_id = module.subnets.output_subnet_public_1c_id

  subnet_private_1a_id = module.subnets.output_subnet_private_1a_id
  subnet_private_1b_id = module.subnets.output_subnet_private_1b_id
  subnet_private_1c_id = module.subnets.output_subnet_private_1c_id

  depends_on = [
    module.ngw
  ]
}

# 7 - Create Security Group
module "security_group" {
  source       = "./modules/security_group"
  aws_vpc_id   = module.vpc.output_vpc_id
  project_name = var.project_name

  depends_on = [
    module.route_table
  ]
}

# 8 - Create IAM Policies
module "iam_policy" {
  source       = "./modules/iam_policy"
  project_name = var.project_name

  depends_on = [
    module.security_group
  ]
}

# 9 - Create IAM Roles
module "iam_role" {
  source                = "./modules/iam_role"
  ebs_driver_policy_arn = module.iam_policy.output_ebs_driver_policy_arn
  project_name          = var.project_name
  # cluster_identity_oidc_issuer_arn = module.eks.output_oidc_provider_arn
  # cluster_identity_oidc_issuer     = module.eks.output_oidc_provider_issuer
  # external_dns_policy_arn          = module.iam_policy.output_external_dns_policy_arn
  #alb_controller_assume_role_policy = module.eks.output_alb_controller_assume_role_policy
  depends_on = [
    module.iam_policy
  ]
}

# 10 - Create EKS Cluster
module "eks-cluster" {
  source           = "./modules/eks-cluster"
  eks_iam_role_arn = module.iam_role.output_eks_cluster_iam_role_arn
  project_name     = var.project_name
  eks_version      = var.eks_version

  subnet_public_1a_id = module.subnets.output_subnet_public_1a_id
  subnet_public_1b_id = module.subnets.output_subnet_public_1b_id
  subnet_public_1c_id = module.subnets.output_subnet_public_1c_id

  subnet_private_1a_id = module.subnets.output_subnet_private_1a_id
  subnet_private_1b_id = module.subnets.output_subnet_private_1b_id
  subnet_private_1c_id = module.subnets.output_subnet_private_1c_id

  eks_cluster_sg_id = module.security_group.output_security_group_eks_cluster_id

  depends_on = [
    module.iam_policy,
    module.iam_role
  ]
}


# 11 - Create Node Group
module "node_group" {
  source                  = "./modules/node_group"
  project_name            = var.project_name
  aws_eks_cluster_name    = module.eks-cluster.output_aws_eks_cluster_name
  eks_node_group_role     = module.iam_role.output_eks_node_group_role_arn
  aws_eks_cluster_version = module.eks-cluster.output_eks_cluster_version

  subnet_private_1a_id = module.subnets.output_subnet_private_1a_id
  subnet_private_1b_id = module.subnets.output_subnet_private_1b_id
  subnet_private_1c_id = module.subnets.output_subnet_private_1c_id

  node_group_desired_size    = var.node_group_desired_size
  node_group_max_size        = var.node_group_max_size
  node_group_min_size        = var.node_group_min_size
  node_group_max_unavailable = var.node_group_max_unavailable

  depends_on = [
    module.eks-cluster
  ]
}

# 12 - Addons in EKS Cluster
module "eks_addons" {
  source               = "./modules/eks_addons"
  aws_eks_cluster_name = module.eks-cluster.output_aws_eks_cluster_name
  depends_on = [
    module.node_group
  ]
}
