#Common
project_name = "vinayak"
region       = "ap-south-1"

#VPC Variables
vpc_cidr_block = "10.0.0.0/16"
# vpc_name       = ""

# #S3 Variables
# frontend_admin_bucket_name = ""
# db_backup_bucket_name      = ""
# media_bucket_name          = ""

# #Security Group Variables

# #Subnet Variables
cidr_block_public_1a = "10.0.0.0/24"
cidr_block_public_1b = "10.0.1.0/24"
cidr_block_public_1c = "10.0.2.0/24"

cidr_block_private_1a = "10.0.3.0/24"
cidr_block_private_1b = "10.0.4.0/24"
cidr_block_private_1c = "10.0.5.0/24"

az_1a = "ap-south-1a"
az_1b = "ap-south-1b"
az_1c = "ap-south-1c"

# #Route Table Variables
# #EIP Variables
# #IGW Variables
# #NGW VAriables

# #IAM Policy Variables
# #IAM Role Varibles
# #EKS Variables
eks_version = "1.24"

# #EKS Addons Variables
# #NodeGroup
node_group_desired_size    = "1"
node_group_max_size        = "2"
node_group_min_size        = "1"
node_group_max_unavailable = "1"

