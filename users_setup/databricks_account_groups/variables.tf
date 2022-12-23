variable "group_name"{
  description = "Group name to be created"
  type = string
}

variable "group_memberships" {
  description = "Set of users to be added to the given group"
  type        = set(string)
}

variable "user_id_map" {
  type = map(string)
}
