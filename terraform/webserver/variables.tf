### Variables

variable "aws_region"  { type = string }
variable "project_name" { type = string }
variable "ec2_instance_name" { type = string }
variable "project_env" { type = string }
variable "vpc_cidr_block" { type = string }
variable "public_subnet_cidr_block" { type = string }
variable "ssh_key_name" { type = string }
variable "instance_type" { type = string }
variable "ssh_public_key_path" { type = string }  

