variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "env" {
  type        = string
  description = "Environment for which the infrastructure is being created"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

#Networking Related.
###########################################
variable "vpc_cidr" {
  type        = string
  description = "CIDR Range for our VPC"
  default     = "10.10.0.0/16"
}
variable "public_subnet_cidr_blocks" {
  default     = ["10.20.0.0/20", "10.20.16.0/20", "10.20.32.0/20"]
  type        = list(any)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.20.128.0/20", "10.20.144.0/20", "10.20.160.0/20"]
  type        = list(any)
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  type        = list(any)
  description = "List of availability zones"
}

variable "region" {
  type        = string
  description = "Region of the resources to be created."
  default     = "ap-northeast-1"
}

##########################################################

