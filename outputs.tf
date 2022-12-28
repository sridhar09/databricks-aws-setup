output "databricks_workspaces" {
  value       = module.workspace_setup.databricks_workspaces
  description = "Details of the workspaces created using this terraform stack"
}