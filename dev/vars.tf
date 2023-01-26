variable "region" {}
variable "env" {
  # type = string
  # description = "Environment for which the infrastructure is being created"
}
# variable "tf_bucket_name" {}
# variable "tf_bucket_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "project_name" {
  type        = string
  description = "The name of the project"
}
variable "vpc_cidr" {}
