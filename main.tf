module "vpc_setup" {
  source = "vpc"
  providers = {
    databricks.mws = databricks.mws
  }
  aws_region            = var.aws_region
  cidr_block            = var.vpc_cidr_block
  databricks_account_id = var.databricks_account_id
  default_tags = {
    costcenter = var.costcenter
  }
  prefix = var.resource_prefix
}

module "workspace_setup" {
  source   = "./workspace_setup"
  for_each = toset(keys(yamldecode(file(abspath("./databricks_workspace_assignments.yaml")))["workspace_assignments_config"]))
  providers = {
    databricks.mws = databricks.mws
  }
  aws_region            = var.aws_region
  databricks_account_id = var.databricks_account_id
  databricks_network_id = module.vpc_setup.databricks_network_id
  default_tags = {
    costcenter = var.costcenter
  }
  prefix         = var.resource_prefix
  workspace_name = each.value
}

module "databricks_account_users" {
  source = "./users_setup/databricks_account_users"
  providers = {
    databricks.mws = databricks.mws
  }
  user_yaml_filepath = abspath("./databricks_users.yaml")
}

module "databricks_group_assignments" {
  source = "./users_setup/databricks_group_assignments"
  providers = {
    databricks.mws = databricks.mws
  }
  group_assignments_yaml_filepath = abspath("./databricks_workspace_assignments.yaml")
  databricks_group_ids            = module.databricks_account_users.group_ids
}