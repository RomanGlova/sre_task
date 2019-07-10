resource "aws_db_instance" "sre_db" {
  allocated_storage = 20
  availability_zone = "us-east-1a"
  backup_retention_period = 1
  backup_window ="06:29-06:59"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  deletion_protection = false
  engine = "mysql"
  engine_version = "8.0.15"
  iam_database_authentication_enabled = false
  identifier = "sre-task-db"
  instance_class = "db.t2.micro"
  iops = 0
  license_model = "general-public-license"
  maintenance_window = "tue:05:35-tue:06:05"
  max_allocated_storage = 0
  monitoring_interval = 0
  multi_az = false
  name = var.sre_task_db_name
  option_group_name = "default:mysql-8-0"
  parameter_group_name = "default.mysql8.0"
  performance_insights_enabled = false
  performance_insights_retention_period = 0
  port = 3306
  publicly_accessible = false
  replicate_source_db = ""
  security_group_names = []
  skip_final_snapshot = true
  storage_encrypted = false
  storage_type = "gp2"
  username = data.aws_ssm_parameter.rds_username.value
  password = data.aws_ssm_parameter.rds_password.value
  vpc_security_group_ids = [
    aws_security_group.rds_sec_group.id
  ]
}