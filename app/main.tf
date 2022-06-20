resource "aws_subnet" "private" {
  count             = length(var.subnets_cidr)
  vpc_id            = var.aws_vpc
  cidr_block        = element(var.subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.name}-private-subnet-${count.index + 1}"
  }
}

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

data "aws_subnets" "private" {
  depends_on = [aws_subnet.private]
  filter {
    name   = "vpc-id"
    values = [var.aws_vpc]
  }
  filter {
    name   = "cidr"
    values = var.subnets_cidr
  }
}

resource "aws_instance" "app" {
  depends_on = [data.aws_subnets.private]
  count                  = var.instances
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id              = data.aws_subnets.private.ids[count.index % length(data.aws_subnets.private.ids)]
  tags = {
    Name  = "${var.name}-ec2-${count.index + 1}"
    email = var.email
  }
}

resource "aws_lb_target_group_attachment" "ec2" {
  count            = var.instances
  target_group_arn = var.tg
  target_id        = var.ec2[count.index]
  port             = 80
}

output "ec2" {
  value = aws_instance.app.*.id
}