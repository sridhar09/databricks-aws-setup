resource "databricks_group" "this" {
  provider     = databricks.mws
  display_name = var.group_name
}

resource "databricks_group_member" "group_member" {
  provider  = databricks.mws
  for_each  = var.group_memberships
  group_id  = databricks_group.this.id
  member_id = var.user_id_map[each.value]
}