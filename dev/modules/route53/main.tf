
resource "aws_route53_record" "www" {
  zone_id = var.route53_zone_id
  count   = length(var.domains_list)
  name    = element(var.domains_list, count.index)
  type    = "A"

  alias {
    name                   = var.shared_alb_dns_name
    zone_id                = var.shared_alb_zone_id
    evaluate_target_health = true
  }
}
