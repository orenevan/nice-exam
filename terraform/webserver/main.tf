# Define AWS provider
provider "aws" {
  region = var.aws_region # Change to your desired region
  default_tags {
    tags = local.base_tags
  }


}


# Define VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" 
  # Enable DNS support and DNS hostnames
  enable_dns_support   = true
  enable_dns_hostnames = true

   tags = {
    Name = "${var.project_name}-jenkinsvpc"
  }

 
}
