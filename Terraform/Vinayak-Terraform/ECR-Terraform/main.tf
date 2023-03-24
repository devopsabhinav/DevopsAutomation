#ECR create

resource "aws_ecr_repository" "ecr_create" {
  count = length(var.ecr_name)
  name  = "${var.project_name}-${element(var.ecr_name, count.index)}"
}

