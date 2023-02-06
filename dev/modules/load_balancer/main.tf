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


resource "aws_lb_target_group" "shared_target_group" {
  name     = "${var.project_name}-${var.env}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "shared_target_group_https" {
  name     = "${var.project_name}-${var.env}-https-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "shared_lb_listener_1" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.shared_target_group.arn

  }

}


# resource "aws_elbv2_listener" "go" {
#   load_balancer_arn = aws_lb.default.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     target_group_arn = aws_lb_target_group.shared_target_group.arn
#     type             = "forward"
#   }
# }
# resource "aws_elbv2_listener_rule" "go" {
#   listener_arn = aws_elbv2_listener.go.arn
#   priority     = 1

#   action {
#     type = "forward"

#     target_group_arn = aws_elastic_beanstalk_environment.go.endpoint.0.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/go/*", "/go"]
#     }
#   }
# }
