provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {
    tags = {
      project     = var.project_name
      environment = var.env
    }
  }
}

terraform {

  backend "s3" {
    bucket = "proj1-state-bucket"
    key    = "dev/terraform_dev_statefile"
    region = "ap-northeast-1"
  }
}

