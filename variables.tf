variable "vpc_id" {
  description = "Deployment VPC id"
  default = "vpc-04ef9361"
}

variable "sre_task_db_name" {
  description = "RDS DB name"
  default = "mydb"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "294096918629.dkr.ecr.us-east-1.amazonaws.com/sre_task_web"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "execution_role_arn" {
  description = "Fargate execution role arn"
}