# HUG Lagos/Ibadan Terraform Challenge — Week One Project 1

Deploys a basic web server on AWS using Terraform: a custom VPC, public subnet,
Internet Gateway, route table, security group (SSH + HTTP), and an EC2 instance
running Nginx that serves a simple HTML page.

## Prerequisites

- Terraform installed (v1.5+)
- AWS CLI installed and configured with credentials (aws configure)
- An existing EC2 key pair in your target region (optional, only needed if you
  want SSH access — leave key_name blank in variables if not needed)

## Files

- provider.tf — AWS provider configuration
- variables.tf — input variables (region, CIDR blocks, instance type, your name)
- network.tf — VPC, public subnet, Internet Gateway, route table
- security_group.tf — security group allowing SSH (22) and HTTP (80)
- main.tf — EC2 instance + user_data script that installs and configures Nginx
- outputs.tf — outputs the instance's public IP and website URL

## Deployment Steps

1. Clone this repo and cd into it:
   bash
   git clone <your-repo-url>
   cd terraformHUG
   

2. (Optional) Edit variables.tf to set your full name and preferred region:
   hcl
   variable "full_name" {
     default = "Your Full Name"
   }
   
   Or override at apply time (see step 5).

3. Initialize Terraform (downloads the AWS provider):
   bash
   terraform init
   

4. Preview the plan:
   bash
   terraform plan
   

5. Apply (deploys the infrastructure):
   bash
   terraform apply -var="full_name=Your Full Name"
   
   Type yes when prompted.

6. Once complete, Terraform prints the website_url output. Wait ~1 minute for
   the instance to finish booting and installing Nginx, then open that URL in
   your browser.

7. Take your screenshots:
   - The webpage showing your name and "HUG Lagos/Ibadan Terraform Challenge"
   - The AWS EC2 console showing the instance in a "Running" state

8. When done, tear down the infrastructure to avoid ongoing charges:
   bash
   terraform destroy
   
   Type yes when prompted.

## Notes

- Uses the latest Amazon Linux 2 AMI automatically (via a data source), so no
  AMI ID needs to be hardcoded.
- t2.micro is used by default, which is Free Tier eligible.
- The security group opens SSH and HTTP to 0.0.0.0/0 for simplicity — in a
  real production setup, SSH access should be restricted to a specific IP.