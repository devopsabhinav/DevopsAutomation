variable "eks_cluster_managed_policy_arns" {
  type    = list(any)
  default = ["AmazonEKS_CNI_Policy", "AmazonEKSVPCResourceController", "AmazonEKSClusterPolicy"]

}
variable "ebs_driver_policy_arn" {
  type    = string
  default = "null"
}

variable "eks_node_managed_policy_arns" {
  type    = list(any)
  default = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy", "AmazonRoute53FullAccess"]
}

variable "project_name" {
  type = string
  #default = "null"
}


