resource "aws_security_group" "public" {
  name        = "${var.name}-allow-traffic"
  description = "Allow traffic"
  vpc_id      = var.aws_vpc

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "lb" {
  name               = "${var.name}-lb"
  subnets            = var.public_subnets
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]

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

resource "aws_lb_target_group_attachment" "ec2" {
  count            = var.instances
  target_group_arn = aws_lb_target_group.test-tf.arn
  target_id        = var.ec2[count.index]
  port             = 80
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