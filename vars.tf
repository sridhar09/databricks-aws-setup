variable "databricks_password_secret_path" {
  description = "ASM path for the databricks secret e.g. prefix/databricks/password"
  type        = string
}

variable "databricks_admin_username" {
  description = "Complete email address of the Databricks admin"
  type        = string
}

variable "databricks_account_id" {
  description = "The account id for the databricks account where the workspace need be created"
  type = string
}

variable "aws_region" {
  description = "The AWS region for the workspace & resources"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIDR Block to be used for the databricks network confiuration"
  type = string
}

variable "costcenter" {
  default = "This value will be added to the costcenter tag for all resources"
}

variable "resource_prefix" {
  description = "Prefix for the Databricks & AWS resources created in this module"
  type = string
}