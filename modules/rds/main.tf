resource "aws_db_instance" "default" {
  #checkov:skip=CKV_AWS_157:Multi-AZ is disabled to save money
  #checkov:skip=CKV_AWS_118:Enhanced monitoring is disabled to save money (it's included in CW free tier, but total cost needs to be calculated)
  #checkov:skip=CKV2_AWS_30:Query logging is disabled to save money (it's included in CW free tier, but total cost needs to be calculated)
  #checkov:skip=CKV_AWS_16:Storage encryption is disabled to save money (~$1/month)

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
}
