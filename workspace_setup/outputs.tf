output "databricks_workspace_name" {
  value = databricks_mws_workspaces.this.workspace_name
}

output "databricks_workspace_id" {
  value = databricks_mws_workspaces.this.id
}

output "databricks_workspace_id_number" {
  value = tonumber(split("/", databricks_mws_workspaces.this.id)[1])
}

output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}
