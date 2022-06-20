resource "aws_security_group" "private" {
  name        = "${var.name}-allow-http"
  description = "Allow http traffic"
  vpc_id      = var.aws_vpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  count                  = var.instances
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id              = var.private_subnets[count.index % length(var.private_subnets)]
  tags = {
    Name  = "${var.name}-ec2-${count.index + 1}"
    email = var.email
  }
}

resource "aws_lb_target_group_attachment" "ec2" {
  count            = var.instances
  target_group_arn = var.tg
  target_id        = aws_instance.app.*.id[count.index]
  port             = 80
}