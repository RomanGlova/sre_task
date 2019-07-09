### ECS

resource "aws_ecs_cluster" "main" {
  name = "tf-ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn = var.execution_role_arn

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${var.app_image}",
    "memory": ${var.fargate_memory},
    "name": "app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ],
    "secrets": [
      {
        "name": "MYSQL_USER",
        "valueFrom": "${data.aws_ssm_parameter.rds_username.arn}"
      },
      {
        "name": "MYSQL_PASSWORD",
        "valueFrom": "${data.aws_ssm_parameter.rds_password.arn}"
      }
    ],
    "environment": [
      { "name" : "MYSQL_DATABASE", "value" : "${var.sre_task_db_name}" },
      { "name" : "DB_HOST", "value" : "${aws_db_instance.sre_db.address}" }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "main" {
  name            = "tf-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         =  aws_subnet.private.*.id

  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "app"
    container_port   = var.app_port
  }

  depends_on = [
    "aws_alb_listener.front_end",
  ]
}

output "alb_url" {
  value = "http://${aws_alb.main.dns_name}"
}