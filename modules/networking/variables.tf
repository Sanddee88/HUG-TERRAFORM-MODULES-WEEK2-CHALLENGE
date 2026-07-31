variable "vpc_id" {
    description = "ID of the VPC to attach networking resources to"
    type = string
}
variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
}
variable "name_prefix" {
    description = "Prefix used for naming networking resources"
    type = string
}