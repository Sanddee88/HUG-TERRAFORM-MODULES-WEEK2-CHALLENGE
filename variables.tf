variable "aws_region" {
  description = "AWS region to deploy into"
  type = string
  default = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type = string
  default = "10.0.1.0/24"
}
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.micro"
}
variable "full_name" {
  description = "Sandra Aniude"
  type = string
  default = "Sandra Aniude"
}
variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access"
  type = string
  default = ""
}
variable "name_prefix" {
  description = "Prefix used for naming all resources"
  type = string
  default = "hug-terraform"
}