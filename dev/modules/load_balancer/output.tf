output "shared_alb_arn" {
  value = aws_lb.default.arn
}

output "shared_alb_id" {
  value = aws_lb.default.id
}

output "shared_alb_dns_name" {
  value = aws_lb.default.dns_name
}

output "shared_alb_zone_id" {
  value = aws_lb.default.zone_id
}
