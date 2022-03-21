resource "aws_db_instance" "default" {
  #checkov:skip=CKV_AWS_157:Multi-AZ is disabled to save money
  #checkov:skip=CKV_AWS_118:Enhanced monitoring is disabled to save money (it's included in CW free tier, but total cost needs to be calculated)
  #checkov:skip=CKV2_AWS_30:Query logging is disabled to save money (it's included in CW free tier, but total cost needs to be calculated)
  #checkov:skip=CKV_AWS_16:Storage encryption is disabled to save money (~$1/month)

  identifier                          = "${var.name}-master"
  allocated_storage                   = 20
  engine                              = "postgres"
  engine_version                      = "12.10"
  instance_class                      = "db.t2.micro"
  db_name                             = var.database_name
  username                            = var.db_credentials.username
  password                            = var.db_credentials.password
  skip_final_snapshot                 = true
  db_subnet_group_name                = var.subnet_group_name
  enabled_cloudwatch_logs_exports     = ["postgresql"]
  storage_encrypted                   = false
  auto_minor_version_upgrade          = true
  iam_database_authentication_enabled = true
  backup_window                       = "02:00-03:00"
  backup_retention_period             = 7
  deletion_protection                 = true
  maintenance_window                  = "Mon:03:00-Mon:04:00"
  vpc_security_group_ids              = [aws_security_group.api.id]
}

#TODO: Need to be tested
#TODO: Verify if we can allow less
resource "aws_security_group" "api" {
  name        = "allow-api"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow traffic to Postgres"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow outbound traffic"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
