//You must also initialize the provider with alias = "mws" and use provider = databricks.mws for all databricks_mws_* resources.
//The provider requires all databricks_mws_* resources to be created within its own dedicated Terraform module of your environment.
//Usually this module creates VPC and IAM roles as well.
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_secretsmanager_secret" "databricks_password" {
  name = var.databricks_password_secret_path
}

data "aws_secretsmanager_secret_version" "databricks_password" {
  secret_id = data.aws_secretsmanager_secret.databricks_password.id
}

// initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias      = "mws"
  host       = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  username   = var.databricks_admin_username
  password   = data.aws_secretsmanager_secret_version.databricks_password.secret_string
}