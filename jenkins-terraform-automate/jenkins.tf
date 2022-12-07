# resource "helm_release" "jenkins" {
#   name       = "jenkins"

#   repository = "https://charts.jenkins.io"
#   chart      = "jenkins"

#   values = [
#     "${file("values.yaml")}"
#   ]

#   set {
#     name  = "service.type"
#     value = "ClusterIP"
#   }
# }

resource "null_resource" "pvcreate" {
  depends_on = [
    aws_efs_mount_target.jenkins_mt1
  ]
  provisioner "local-exec" {
    command = "helm install pv /Users/yudiz/Documents/jenkins-terraform-automate/pv --set pv='${aws_efs_file_system.jenkins_fs.id}::${aws_efs_access_point.jenkins_ap.id}'" 
  }
}


resource "null_resource" "jenkins" {
  depends_on = [
    null_resource.efs_csi_driver-command
  ]
  provisioner "local-exec" {
    command = "helm install jenkins jenkins/jenkins -f /Users/yudiz/Documents/jenkins-terraform-automate/values.yaml"
  }
}

# # helm repo add jenkins https://charts.jenkins.io
# # helm repo update

# // csi driver

resource "null_resource" "efs_csi_driver-command" {
  depends_on = [
    null_resource.pvcreate
  ]
  provisioner "local-exec" {
    #  command = "helm install my-aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver --version 2.3.2"
    command = <<-EOT
        helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
        helm repo update
        helm upgrade -i aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver --namespace kube-system --set image.repository=602401143452.dkr.ecr.us-east-2.amazonaws.com/eks/aws-efs-csi-driver --set controller.serviceAccount.create=false --set controller.serviceAccount.name=efs-csi-controller-sa
        aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output text
    EOT
  }
}

