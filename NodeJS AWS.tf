# Fichier main.tf

provider "aws" {
  region = "us-west-2"
}

resource "aws_ecs_cluster" "example" {
  name = "my-cluster"
}

resource "aws_ecr_repository" "example" {
  name = "my-repo"
}

resource "aws_ecs_task_definition" "example" {
  family                = "my-task"
  container_definitions = <<DEFINITION
[
  {
    "name": "my-container",
    "image": "my-ecr-repo:latest",
    "cpu": 256,
    "memory": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "example" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.example.arn
    container_name   = aws_ecs_task_definition.example.container_definitions[0].name
    container_port   = aws_ecs_task_definition.example.container_definitions[0].portMappings[0].containerPort
  }
}

resource "aws_lb" "example" {
  name               = "my-lb"
  load_balancer_type = "application"

  subnet_mapping {
    subnet_id = aws_subnet.example.id
  }
}

resource "aws_lb_target_group" "example" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.example.id
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}
