variable "vpc_id" {
  description = "Deployment VPC id"
  default = "vpc-04ef9361"
}

variable "sre_db_user" {
  description = "RDS db user"
}

variable "sre_db_pass" {
  description = "RDS db password"
}