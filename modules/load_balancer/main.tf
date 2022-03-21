resource "aws_lb" "default" {
  #checkov:skip=CKV2_AWS_28:TODO:Do research and decide if we can use it
  #checkov:skip=CKV_AWS_91:Disabled to save money
  #checkov:skip=CKV_AWS_158:Disabled to save money

  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.default.id]
  subnets                    = var.network.public_subnets
  drop_invalid_header_fields = true

  enable_deletion_protection = true
}

resource "aws_security_group" "default" {
  name        = "${var.name}-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.network.vpc_id

  ingress {
    description      = "Allow HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow ALB connect to EC2s in Private subnet"
    protocol    = "tcp"
    # access to all ports is needed because we don't know on which port Docker instance will be run
    # More: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PortMapping.html
    from_port       = 49153
    to_port         = 65535
    security_groups = var.network.security_groups
  }
}

resource "aws_lb_listener" "redirect_to_https" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.default_target_group_arn
  }
}

resource "aws_route53_record" "default" {
  zone_id         = var.zone_id
  name            = var.domain_name
  allow_overwrite = true
  type            = "A"

  alias {
    name                   = aws_lb.default.dns_name
    zone_id                = aws_lb.default.zone_id
    evaluate_target_health = true
  }
}
