variable "prefix" {
  description = "Prefix for the Databricks & AWS resources created in this module"
  type        = string
}

variable "workspace_name" {
  description = "Name of the workspace to be created"
  type        = string
}

variable "default_tags" {
  description = "Default tags for all relevant resources created in this module"
  type        = map(string)
}

variable "databricks_account_id" {
  description = "The account id for the databricks account where the workspace need be created"
  type        = string
}

variable "databricks_network_id" {
  description = "The network id for the databricks vpc"
  type        = string
}

variable "aws_region" {
  description = "The AWS region for the workspace & resources"
  type        = string
}