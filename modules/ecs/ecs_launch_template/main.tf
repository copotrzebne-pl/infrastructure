locals {
  instance_user_data = <<EOF
#!/bin/bash
# The cluster this agent should check into.
echo 'ECS_CLUSTER=${var.cluster_name}' >> /etc/ecs/ecs.config
# Disable privileged containers.
echo 'ECS_DISABLE_PRIVILEGED=true' >> /etc/ecs/ecs.config
EOF
}

resource "aws_launch_template" "ec2_launch_template" {
  name          = var.name
  instance_type = var.instance_type
  image_id      = jsondecode(data.aws_ssm_parameter.amazon_linux_id.value).image_id

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_instance_profile.arn
  }

  network_interfaces {
    security_groups             = var.security_groups
    associate_public_ip_address = var.assign_public_ip
  }

  user_data = base64encode(local.instance_user_data)

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

data "aws_ssm_parameter" "amazon_linux_id" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecsInstanceRole-${var.name}"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs-instance-role-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
