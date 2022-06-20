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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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

output "private_sg" {
  value = aws_security_group.private.id
}

output "public_sg" {
  value = aws_security_group.public.id
}