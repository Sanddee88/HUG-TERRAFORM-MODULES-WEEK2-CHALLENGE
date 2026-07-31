# HUG Lagos/Ibadan Terraform Challenge - Week Two Project 2

Refactors Week One's infrastructure into reusable Terraform modules, and
stores Terraform state remotely in an S3 bucket with DynamoDB state locking.

## Project structure


terraform-modules-project/
├── modules/
│   ├── vpc/                # Creates the VPC
│   ├── networking/         # Subnet, Internet Gateway, route table
│   ├── security_group/     # Security group (SSH + HTTP)
│   └── compute/            # EC2 instance + Nginx user_data script
├── provider.tf             # AWS provider configuration
├── backend.tf              # Remote backend (S3 + DynamoDB)
├── variables.tf            # Root input variables
├── main.tf                 # Calls all four modules
├── outputs.tf               # Root outputs (public IP, website URL, VPC ID)
└── README.md


## Prerequisites

- Terraform installed (v1.5+)
- AWS CLI installed and configured (`aws configure`)
- An AWS account with permissions to create S3 buckets, DynamoDB tables, VPCs, EC2 instances, and security groups

## Step 1 — One-time remote backend setup

Terraform's S3 backend cannot create its own bucket/table - these must exist
*before* running `terraform init`. Run this once, from any terminal with
AWS CLI configured:

```bash
# Create the S3 bucket for state storage (must be globally unique - edit the name)
# Note: us-east-1 does NOT use --create-bucket-configuration
aws s3api create-bucket \
  --bucket hug-terraform-state-sanddee-2026 \
  --region us-east-1 

# Enable versioning (protects against accidental state corruption/loss)
aws s3api put-bucket-versioning \
  --bucket hug-terraform-state-sanddee-2026 \
  --versioning-configuration Status=Enabled

# Create the DynamoDB table for state locking (prevents concurrent applies)
aws dynamodb create-table \
  --table-name hug-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1


If you change the bucket name or region, update backend.tf to match exactly.

## Step 2 — Deploy the infrastructure

bash
terraform init      # downloads providers AND connects to the S3 backend
terraform plan
terraform apply      # type 'yes' when prompted


terraform init will detect the backend block and configure remote state
automatically. You can confirm state is stored remotely (not locally) by
checking that no terraform.tfstate file appears in your project folder —
instead, check the S3 bucket via the AWS console or:
bash
aws s3 ls s3://hug-terraform-state-sanddee-2026/week2/


## Step 3 — Verify

Once applied, Terraform prints website_url. Open it in your browser —
you should see your name and "HUG Lagos/Ibadan Terraform Challenge".

Take your screenshots:
- The webpage
- AWS Console → EC2 → Instances (showing it running)

## Step 4 — Tear down

bash
terraform destroy


The S3 bucket and DynamoDB table used for the backend are NOT destroyed by
this command (they're managed outside Terraform) — delete them manually via
the console or CLI if you want to remove them entirely.

## Notes on modules

- Each module is self-contained with its own variables.tf (inputs) and
  outputs.tf (values passed to other modules or the root config).
- The root main.tf wires modules together by passing one module's output
  as another's input — e.g., module.vpc.vpc_id is passed into both the
  networking and security_group modules.
- This structure means each module (vpc, networking, security_group,
  compute) could be reused in another project by just changing the input
  variables — no need to rewrite the underlying resource logic.