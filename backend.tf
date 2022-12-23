terraform {
  backend "s3" {
    bucket = "<BUCKET_NAME>"
    key    = "databricks-setup/terraform.tfstate"
    region = "<AWS_REGION>"
  }
}