// EFS creation 

resource "aws_efs_file_system" "jenkins_fs" {
  creation_token = "jenkins_fs"
  encrypted = true
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"

  tags = {
    Name = "MyEFSFileSystem"
  }
}

# // EFS policy 

# resource "aws_efs_file_system_policy" "policy" {
#   file_system_id = aws_efs_file_system.jenkins_fs.id

#   bypass_policy_lockout_safety_check = true

#   policy = <<POLICY
#   {
#     "Version": "2012-10-17",
#     "Id": "ExamplePolicy01",
#     "Statement": [
#         {
#             "Sid": "ExampleStatement01",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "*"
#             },
#             "Action": [
#                 "elasticfilesystem:ClientMount",
#                 "elasticfilesystem:ClientRootAccess",
#                 "elasticfilesystem:ClientWrite"
#             ],
#             "Resource": aws_efs_file_system.jenkins_fs.arn
#             "Condition": {
#                 "Bool": {
#                     "aws:SecureTransport": "true"
#                 }
#             }
#         }
#     ]
#   }
# POLICY
# }

# resource "aws_efs_file_system_policy" "policy" {
#   file_system_id = aws_efs_file_system.jenkins_fs.id

#   bypass_policy_lockout_safety_check = true

#   policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Id": "ExamplePolicy01",
#     "Statement": [
#         {
#             "Sid": "ExampleStatement01",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "*"
#             },
#             "Resource": "${aws_efs_file_system.jenkins_fs.arn}",
#             "Action": [
#                 "elasticfilesystem:ClientMount",
#                 "elasticfilesystem:ClientRootAccess",
#                 "elasticfilesystem:ClientWrite"
#             ],
#             "Condition": {
#                 "Bool": {
#                     "aws:SecureTransport": "true"
#                 }
#             }
#         }
#     ]
# }
# POLICY
# }


// access point

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
}



//Security group

resource "aws_security_group" "efs_mount_sg" {
  name        = "efs_mount_sg"
  description = "Amazon EFS for EKS, SG for mount target"
  vpc_id      = var.vpc_id
  ingress {
    description      = "TLS from VPC"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    # cidr_blocks      = [aws_vpc.jenkins_vpc.cidr_block]
    cidr_blocks      = ["192.168.0.0/16"]
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
    Name = "allow_tls"
  }
}



// Mount target


resource "aws_efs_mount_target" "jenkins_mt1" {
  # count = 2
  file_system_id = aws_efs_file_system.jenkins_fs.id
  subnet_id = var.subnet_id1
  security_groups = [aws_security_group.efs_mount_sg.id]
}

resource "aws_efs_mount_target" "jenkins_mt2" {
  # count = 2
  file_system_id = aws_efs_file_system.jenkins_fs.id
  subnet_id = var.subnet_id2
  security_groups = [aws_security_group.efs_mount_sg.id]
}

resource "aws_efs_mount_target" "jenkins_mt3" {
  # count = 2
  file_system_id = aws_efs_file_system.jenkins_fs.id
  subnet_id = var.subnet_id3
  security_groups = [aws_security_group.efs_mount_sg.id]
}



# resource "aws_efs_mount_target" "jenkins_mt1" {
#   # count = 2
#   file_system_id = aws_efs_file_system.jenkins_fs.id
#   subnet_id = "subnet-0aabae8c6ffa44f43"
#   security_groups = [aws_security_group.efs_mount_sg.id]
# }

# resource "aws_efs_mount_target" "jenkins_mt2" {
#   # count = 2
#   file_system_id = aws_efs_file_system.jenkins_fs.id
#   subnet_id = "subnet-04c000a76a20878bf"
#   security_groups = [aws_security_group.efs_mount_sg.id]
# }

