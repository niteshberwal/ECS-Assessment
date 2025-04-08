resource "aws_ecs_cluster" "frontend_backend_cluster" {
  name = "frontend-backend-cluster"
}

resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "frontend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  # Task-level CPU and memory (required for Fargate)
  cpu       = "256"   # Task-level CPU allocation (in CPU units)
  memory    = "512"   # Task-level memory allocation (in MB)

  container_definitions = jsonencode([{
    name      = "frontend"
    image     = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.repo_name}:${var.fe_repo_tag}"
    cpu       = 128    # Container-level CPU allocation (in CPU units)
    memory    = 256    # Container-level memory allocation (in MB)
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_task_definition" "backend_task" {
  family                   = "backend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  # Task-level CPU and memory (required for Fargate)
  cpu       = "256"   # Task-level CPU allocation (in CPU units)
  memory    = "512"   # Task-level memory allocation (in MB)

  container_definitions = jsonencode([{
    name      = "backend"
    image     = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.repo_name}:${var.be_repo_tag}"
    cpu       = 128    # Container-level CPU allocation (in CPU units)
    memory    = 256    # Container-level memory allocation (in MB)
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }]
  }])
}

