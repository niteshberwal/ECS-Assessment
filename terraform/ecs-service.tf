resource "aws_ecs_service" "frontend_service" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.frontend_backend_cluster.id
  task_definition = aws_ecs_task_definition.frontend_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
    security_groups  = [aws_security_group.frontend_sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
    container_name   = "frontend"
    container_port   = 80
  }
  depends_on = [
    aws_lb.frontend_alb,
    aws_lb_target_group.frontend_target_group
  ]
}

resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.frontend_backend_cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
    security_groups  = [aws_security_group.backend_sg.id]
    assign_public_ip = false
  }
}
