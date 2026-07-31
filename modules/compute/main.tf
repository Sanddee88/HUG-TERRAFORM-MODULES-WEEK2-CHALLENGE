data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name    = "name"
        values  = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
resource "aws_instance" "web" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    associate_public_ip_address = true
    key_name = var.key_name != "" ? var.key_name : null
    user_data = <<-EOF2
          #!/bin/bash
          yum update -y
          amazon-linux-extras install nginx1 -y
          systemctl enable nginx
          systemctl start nginx
          cat <<'HTML'> /usr/share/nginx/html/index.html
          <!DOCTYPE html>
          <html>
          <head><title>HUG Terraform Challenge</title></head>
          <body style="font-family: Arial, sans-serif; text-align: center; margin-top: 100px;">
          <h1>${var.full_name}</h1>
          <h2>HUG Lagos/Ibadan Terraform Challenge</h2>
          </body>
          </html>
          HTML
          systemctl restart nginx
          EOF2
 tags = { 
    Name = "${var.name_prefix}-web-server"
 }          
}