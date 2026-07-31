variable "vpc_id" {
    description = "ID of the VPC to attach the security group to"
    type = string
}
variable "name_prefix" {
    description = "Prefix used for naming the security gorup"
    type = string
}