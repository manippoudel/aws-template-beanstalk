variable "env" {}
variable "project_name" {}
variable "route53_zone_id" {
  type = string

}
variable "route53_name" {
  type = string

}
variable "shared_alb_dns_name" {
  type = string
}

variable "shared_alb_zone_id" {
  type = string
}

variable "domains_list" {
  type = list(any)
  description = "This is the list of domains or sub domains we will use to configure for the AWS record."
}