provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "sre-task-tf"
    key    = "sre-task.tf"
    region = "us-east-1"
  }
}

resource "aws_security_group" "rds_sec_group" {
  name = "rds-security-group"
  vpc_id = var.vpc_id
  description = "RDS security group"
  egress {
    cidr_blocks = [
      "172.16.0.0/12"
    ]
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    description = "Outgoing mysql"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
  ingress = [
    {
      cidr_blocks = [
        "172.16.0.0/12"
      ]
      description = "Incoming mysql"
      from_port = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = 3306
    }
  ]
}

resource "aws_db_instance" "sre_db" {
  allocated_storage = 20
  availability_zone = "us-east-1c"
  backup_retention_period = 1
  backup_window ="06:29-06:59"
  db_subnet_group_name = "default"
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
  name = "mydb"
  option_group_name = "default:mysql-8-0"
  parameter_group_name = "default.mysql8.0"
  password = var.sre_db_pass
  performance_insights_enabled = false
  performance_insights_retention_period = 0
  port = 3306
  publicly_accessible = false
  replicate_source_db = ""
  security_group_names = []
  skip_final_snapshot = true
  storage_encrypted = false
  storage_type = "gp2"
  username = var.sre_db_user
  vpc_security_group_ids = [
    aws_security_group.rds_sec_group.id
  ]
}