data "aws_ssm_parameter" "rds_username" {
  name = "sre-task-rds-username"
}

data "aws_ssm_parameter" "rds_password" {
  name = "sre-task-rds-password"
}