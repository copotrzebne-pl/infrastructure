resource "aws_ecs_cluster" "this" {
  name = var.name

  #checkov:skip=CKV_AWS_223: ECS Exec logging is disabled to save the money
  configuration {
    execute_command_configuration {
      logging = "NONE"
    }
  }

  #checkov:skip=CKV_AWS_65: Container insights are disabled to save the money
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "ec2_providers" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [aws_ecs_capacity_provider.ec2_provider.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ec2_provider.name
  }
}

resource "aws_ecs_capacity_provider" "ec2_provider" {
  name = "${var.name}-ec2-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ec2_autoscaling.arn
  }
}

resource "aws_autoscaling_group" "ec2_autoscaling" {
  name                = "${var.name}-asg"
  min_size            = var.scaling.min_size
  max_size            = var.scaling.max_size
  desired_capacity    = var.scaling.desired_capacity
  vpc_zone_identifier = var.network.subnets

  launch_template {
    name = module.launch_template.name
  }

  tag {
    key                 = "Cluster"
    value               = var.name
    propagate_at_launch = true
  }

  enabled_metrics = []
}

module "launch_template" {
  source        = "./ecs_launch_template"
  name          = "${var.name}-lt"
  cluster_name  = aws_ecs_cluster.this.name
  instance_type = var.instance_type

  assign_public_ip = var.network.assign_instance_public_ips
  security_groups  = var.network.security_groups
}
