locals {
  user_config = yamldecode(file(var.user_yaml_filepath))["user_config"]
  users       = toset(flatten([for user_list in local.user_config : user_list if user_list != null]))

}

resource "databricks_user" "unity_users" {
  provider  = databricks.account
  for_each  = local.users
  user_name = each.key

  lifecycle {
    prevent_destroy = true
  }
}

module "databricks_account_group" {
  source   = "../databricks_account_groups"
  for_each = local.user_config
  providers = {
    databricks.mws = databricks.mws
  }
  group_memberships = coalesce(each.value, [])
  group_name        = each.key
  user_id_map       = tomap({ for users in databricks_user.unity_users : users.user_name => users.id })
}
