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
