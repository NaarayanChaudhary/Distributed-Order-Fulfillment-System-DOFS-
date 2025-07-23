terraform {
  backend "s3" {
    bucket         = "terraform-state"
    key            = "dofs/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}