//You must also initialize the provider with alias = "mws" and use provider = databricks.mws for all databricks_mws_* resources.
//The provider requires all databricks_mws_* resources to be created within its own dedicated Terraform module of your environment.
//Usually this module creates VPC and IAM roles as well.
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.2.0"
      configuration_aliases = [
        databricks.mws
      ]
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}