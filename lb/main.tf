resource "aws_lb" "lb" {
  name               = "${var.name}-lb"
  subnets            = var.public_subnets
  load_balancer_type = "application"
  security_groups    = [var.public_sg]

  tags = {
    Name  = "${var.name}-lb"
    email = var.email
  }
}

resource "aws_lb_target_group" "test-tf" {
  name        = "${var.name}-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.aws_vpc
  target_type = "instance"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.test-tf.id
    type             = "forward"
  }
}

output "dns" {
  value = aws_lb.lb.dns_name
}

output "tg" {
  value = aws_lb_target_group.test-tf.arn
}