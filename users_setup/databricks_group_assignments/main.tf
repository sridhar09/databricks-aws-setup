locals {
  group_config = yamldecode(file(var.group_assignments_yaml_filepath))["workspace_assignments_config"]
  workspaces = toset(flatten([
    for workspace, group_list in local.group_config : [
      for group in group_list : {
        workspace = workspace
        group     = group
      }
    ]
  ]))
}

data "databricks_mws_workspaces" "all" {
  provider = databricks.account
}

resource "databricks_mws_permission_assignment" "assign_team_workspace" {
  provider = databricks.account
  for_each = { for assignment in local.workspaces : "${assignment.workspace}-${assignment.group}" => assignment }

  workspace_id = lookup(data.databricks_mws_workspaces.all.ids, each.value.workspace)
  principal_id = var.databricks_group_ids[each.value.group]
  permissions  = each.value.group == "admin" ? ["ADMIN"] : ["USER"]
}
