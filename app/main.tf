resource "aws_instance" "app" {
  depends_on             = [var.private_subnets_id]
  count                  = var.instances
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.private_sg]
  subnet_id              = var.private_subnets_id[count.index % length(var.private_subnets_id)]
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