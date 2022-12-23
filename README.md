# databricks-aws-setup

## Project Setup

1. Install tfenv: `brew install tfenv`
2. Export environment variable for AWS programmatic access : https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html
3. Create an ASM secret & store the databricks admin password: https://docs.aws.amazon.com/secretsmanager/latest/userguide/create_secret.html
4. Create a simple S3 bucket ([with versioning enabled](https://docs.aws.amazon.com/AmazonS3/latest/userguide/manage-versioning-examples.html)), Put the name of thid s3 bucket in backend.tf file
5. Update the [databricks_user.yaml](./databricks_users.yaml) & [databricks_workspace_assignments.yaml](databricks_workspace_assignments.yaml)
6. Run terraform init, plan & apply commands : https://developer.hashicorp.com/terraform/cli/commands
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_databricks_account_users"></a> [databricks\_account\_users](#module\_databricks\_account\_users) | users_setup/databricks_account_users | n/a |
| <a name="module_databricks_group_assignments"></a> [databricks\_group\_assignments](#module\_databricks\_group\_assignments) | users_setup/databricks_group_assignments | n/a |
| <a name="module_vpc_setup"></a> [vpc\_setup](#module\_vpc\_setup) | vpc | n/a |
| <a name="module_workspace_setup"></a> [workspace\_setup](#module\_workspace\_setup) | workspace_setup | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.databricks_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.databricks_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region for the workspace & resources | `string` | n/a | yes |
| <a name="input_costcenter"></a> [costcenter](#input\_costcenter) | n/a | `string` | `"This value will be added to the costcenter tag for all resources"` | no |
| <a name="input_databricks_account_id"></a> [databricks\_account\_id](#input\_databricks\_account\_id) | The account id for the databricks account where the workspace need be created | `string` | n/a | yes |
| <a name="input_databricks_admin_username"></a> [databricks\_admin\_username](#input\_databricks\_admin\_username) | Complete email address of the Databricks admin | `string` | n/a | yes |
| <a name="input_databricks_password_secret_path"></a> [databricks\_password\_secret\_path](#input\_databricks\_password\_secret\_path) | ASM path for the databricks secret e.g. prefix/databricks/password | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix for the Databricks & AWS resources created in this module | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR Block to be used for the databricks network confiuration | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_workspaces"></a> [databricks\_workspaces](#output\_databricks\_workspaces) | Details of the workspaces created using this terraform stack |
<!-- END_TF_DOCS -->