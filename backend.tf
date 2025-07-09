terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-central-bucket"
    key            = "terraform_secure_artifacts_bucket/production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-remote-state-lock-table"
    encrypt        = true
  }
}
