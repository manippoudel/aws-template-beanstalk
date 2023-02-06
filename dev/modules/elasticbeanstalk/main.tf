resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "${var.project_name}-${var.env}"
  description = "This elastic beanstalk application is used for ${var.env} project of  ${var.project_name}"

}

resource "aws_elastic_beanstalk_environment" "go_app" {
  name                = "${var.project_name}-${var.env}-go"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.2 running Go 1"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VpcId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.private_subnet_cidr_blocks)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.eb_ec2_sg
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"

  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerIsShared"
    value     = "True"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SharedLoadBalancer"
    value     = var.shared_alb_arn
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "Rules"
    value     = "default, new"
  }

  setting {
    namespace = "aws:elbv2:listenerrule:new"
    name      = "HostHeaders"
    value     = "manippoudel.com"
  }
  setting {
    namespace = "aws:elbv2:listenerrule:new"
    name      = "Priority"
    value     = 2
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = true
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = var.shared_alb_sg
  }
}
##################
#https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-alb-shared.html#environments-cfg-alb-shared-console-example
resource "aws_elastic_beanstalk_environment" "next_app" {
  name                = "${var.project_name}-${var.env}-next"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = "64bit Amazon Linux 2 v5.4.10 running Node.js 14"
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VpcId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.private_subnet_cidr_blocks)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.eb_ec2_sg
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"

  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerIsShared"
    value     = "True"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SharedLoadBalancer"
    value     = var.shared_alb_arn
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "Rules"
    value     = "default, apirule"
  }

  setting {
    namespace = "aws:elbv2:listenerrule:apirule"
    name      = "HostHeaders"
    value     = "api.manippoudel.com"
  }
  setting {
    namespace = "aws:elbv2:listenerrule:apirule"
    name      = "Priority"
    value     = 3
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = true
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = var.shared_alb_sg
  }
}
#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "VpcId"
#     value     = var.vpc_id
#   }
#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "Subnets"
#     # value     = [for private_subnet in var.private_subnet_cidr_blocks : private_subnet]
#     value = join(",", var.private_subnet_cidr_blocks)
#   }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     = "aws-elasticbeanstalk-ec2-role"
#   }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "SecurityGroups"
#     value     = var.eb_ec2_sg
#   }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "InstanceType"
#     value     = "t2.micro"
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "LoadBalancerType"
#     value     = "application"

#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "LoadBalancerIsShared"
#     value     = "True"
#   }
#   setting {
#     namespace = "aws:elbv2:loadbalancer"
#     name      = "SharedLoadBalancer"
#     value     = var.shared_alb_arn
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "EnvironmentType"
#     value     = "LoadBalanced"
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "LoadBalancerType"
#     value     = "application"
#   }
#   setting {
#     namespace = "aws:elbv2:listener:80"
#     name      = "Rules"
#     value     = "firstrule"
#   }
#   # setting {
#   #   namespace = "aws.elbv2:listenerrule:firstrule"
#   #   name      = "HostHeaders"
#   #   value     = "front.manippoudel.com"
#   # }
#   setting {
#     namespace = "aws:elbv2:listenerrule:firstrule"
#     name      = "PathPatterns"
#     value     = "/go/*"
#   }
#   setting {
#     namespace = "aws:elbv2:listenerrule:firstrule"
#     name      = "Priority"
#     value     = 3
#   }

#   setting {
#     namespace = "aws:elbv2:loadbalancer"
#     name      = "SecurityGroups"
#     value     = var.shared_alb_sg
#   }

# }
