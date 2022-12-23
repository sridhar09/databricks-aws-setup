# databricks_group_assignments

Assigns account level groups to individual workspaces in Databricks

## Requirements

| Name | Version |
|------|---------|
| databricks | 1.2.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | 1.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| groups_yaml_filepath | Filepath of the YAML file which contains the group assignment config | `string` | n/a | yes |
| databricks_group_ids | Map of the groups names and ids | `map` | n/a | yes |

## The Group Assignments YAML

The Group Assignments YAML that needs to be passed as input is used to define the workspaces and which groups should be assigned.
Here's a sample YAML file.

```yaml
"group_config":
  "workspace1":
    - "group1"
    - "group2"
  "workspace2":
    - "group1"
    - "group3"
    - "group4"
  "workspace3":
    - "group1"
    - "group4"      
```
    
1. Each workspace has a list of groups which are assigned to that workspace
2. A single group can be assigned to more than 1 workspace
