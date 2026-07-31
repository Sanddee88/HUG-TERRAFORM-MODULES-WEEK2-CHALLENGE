variable "subnet_id"{
    description = "ID of the subnet to launch the instance in"
    type = string
}
variable "security_group_id" {
    description = "ID of the security group to attach"
    type = string
}
variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}
variable "full_name" {
    description = "Full name to display on the webpage"
    type = string
}
variable "key_name" {
    description = "Name of an existing EC2 key pair for SSH access"
    type = string
    default = ""
}
variable "name_prefix" {
    description = "Prefix used for naming the instance"
    type = string
}