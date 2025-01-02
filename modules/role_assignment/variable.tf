variable "assigned_roles_displayname" {
  description = "Specify roles assigned to the groups for Privilege Access"
  type        = string


}

variable "principal_object_id" {
  description = "The object ID of the user, group, or service principal you want to assign the role Role Based Access Control Administrator to."
  type        = string

}
