variable "env" {}
variable "project_name" {}
variable "private_subnet_cidr_blocks" {
  type        = list(any)
  description = "List of private subnet to create the load balancer in different az"
}
variable "vpc_id" {
  description = "ID of the VPC in which security resources are deployed"
  type        = string
}

variable "shared_alb_arn" {
  description = "ID of the ALB"
  type        = string
}

variable "shared_alb_sg" {
  type        = string
  description = "Security Group ID of ALB sg"
}

variable "eb_ec2_sg" {
  description = "Security Group for the ec2 instance beanstalk"
  type        = string
}
