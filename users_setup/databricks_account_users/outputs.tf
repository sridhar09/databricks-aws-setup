output "group_ids" {
  value = {
    for group in module.databricks_account_group : group.group_name => group.group_id
  }
}