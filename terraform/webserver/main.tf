
# Define AWS provider
provider "aws" {
  region = var.aws_region # Change to your desired region
  default_tags {
    tags = local.base_tags
  }
}

# Define VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  # Enable DNS support and DNS hostnames
  enable_dns_support   = true
  enable_dns_hostnames = true

   tags = {
    Name = "${var.project_name}-${var.ec2_instance_name}-vpc"
  }

 
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

   tags = {
    Name = "${var.project_name}-${var.ec2_instance_name}-igw"
  }

}

# Define public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
   tags = {
    Name = "${var.project_name}-${var.ec2_instance_name}-public-subnet"
  }


}

# Create a default route table for the VPC
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "${var.project_name}-${var.ec2_instance_name}-route-table"
  }
}

# Create a route in the default route table to route traffic to Internet Gateway
resource "aws_route" "public_internet" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Associate the public subnet with the default route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_default_route_table.default.id
}

# Define security group
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}


# Define IAM role
resource "aws_iam_role" "iam_role" {
  name = "${var.project_name}-${var.ec2_instance_name}-role"
 
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


# Define IAM instance profile
resource "aws_iam_instance_profile" "webserver_iam_instance_profile" {
  name = "${var.project_name}-${var.ec2_instance_name}-iaminstanceprofile"
  role = aws_iam_role.iam_role.name
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
 
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}



resource "aws_key_pair" "key" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}


# Define EC2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2.id 
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
 
  key_name = aws_key_pair.key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-${var.ec2_instance_name}"
  }

  iam_instance_profile = aws_iam_instance_profile.webserver_iam_instance_profile.name  
  
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install -y nginx1.12 
              sudo systemctl start nginx 
              sudo systemctl enable nginx
              echo "<html><body><h1>Hello, World!</h1></body></html>" > index.html
              sudo cp index.html /usr/share/nginx/html/index.html
              EOF
}


