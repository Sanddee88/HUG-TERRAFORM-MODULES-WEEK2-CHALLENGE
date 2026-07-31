output "instance_public_ip" {
  description = "Public IP address of the web server"
  value = module.compute.public_ip
}

output "website_url" {
  description = "URL to view the webpage"
  value = "http://${module.compute.public_ip}"
}

output "vpc_id" {
  description = "ID of the created VPC"
  value = module.vpc.vpc_id
}