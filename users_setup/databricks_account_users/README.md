# databricks_account_users

Adds account level users & groups for databricks

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
| user_yaml_filepath | Filepath of the YAML file which contains the use config | `string` | n/a | yes |

## The User YAML

The User YAML that needs to be passed as input is used to define the users & groups to be created.
Here's a sample YAML file.

```yaml
"user_config":
  "group1":
    - "user1@itv.com"
    - "user2@itv.com"
    - "user3@itv.com"
    - "user4@itv.com"
  "group2":
    - "user3@itv.com"
    - "user4@itv.com"
    - "user5@itv.com"
  "group3":
    - "user6@itv.com"
    - "user7@itv.com"      
```
    
1. Groups : 
   - All the keys inside `user_config` gets added as a group.
   - The sample file above adds 3 Groups named `group1, group2 & group 3`
2. Users : 
    - Each group has a list of users which are assigned to that group
    - Users will be automatically added to the account if not already exist.
    - The sample file above adds 7 users named `user1@itv.com, user2@itv.com . . . user7@itv.com`
3. A single user can be part of more than 1 group
    - For example `user3@itv.com & user4@itv.com` in the sample YAML are part of both group1 & group2