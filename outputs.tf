output "databricks_workspaces" {
  value       = databricks_mws_workspaces.this
  description = "Details of the workspaces created using this terraform stack"
}