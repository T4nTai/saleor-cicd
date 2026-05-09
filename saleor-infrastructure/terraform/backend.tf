terraform {
  backend "s3" {
    bucket  = "saleor-terraform-state-nguyentanan"
    key     = "saleor-infrastructure/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}