resource "aws_lb" "default" {
  name               = "${var.project_name}-${var.env}-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for public_subnet in var.public_subnet_cidr_blocks : public_subnet]
  security_groups    = [var.alb_sg]
  tags = {
    Name = "${var.project_name}_${var.env}_alb"
  }
}

