variable "devops_project_id" {
  type = string
}

variable "devops_project_contributor_group_id" {
  type = string
}

variable "devops_repository_branch_policy_target" {
  type = string
}

variable "devops_repository_branch_match_type" {
  type = string
}

variable "devops_repository_branch_policy_minimum_reviewer_configuration" {
  type = object({
    reviewer_count = number
    submitter_can_vote = bool
    last_pusher_cannot_approve = bool
    on_push_reset_approved_votes = bool
  })
}

variable "devops_repository_branch_policy_comment_resolution_configuration" {
  type = object({
    enabled = bool
    blocking = bool
  })
}

variable "devops_repository_branch_policy_reviewer_configuration" {
  type = object({
    enabled = bool
    blocking = bool
    minimum_number_of_reviewers = number 
  })
}

variable "devops_repository_branch_policy_work_item_link_configuration" {
  type = object({
    enabled = bool
    blocking = bool 
  })
}