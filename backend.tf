terraform {
    backend "s3" {
        bucket = "hug-terraform-state-sanddee-2026"
        key = "week2/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "hug-terraform-locks"
        encrypt = true
    }
}