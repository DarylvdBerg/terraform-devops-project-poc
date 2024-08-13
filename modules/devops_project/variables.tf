# Project variables
variable "devops_project_name" {
  type = string
}

variable "devops_project_description" {
  type = string
}

variable "devops_project_scrum_template" {
  type = string
}

variable "devops_project_wiki_pages_list" {
  type = map(object({
    sub_pages = set(string)
  }))
}

variable "devops_project_repository_git_permissions" {
  type = object({
    PullRequestBypassPolicy = string
    ForcePush               = string
    PolicyExempt            = string
  })
}

variable "devops_project_client_group_permissions" {
  type = object({
    GENERIC_READ  = string,
    GENERIC_WRITE = string
  })
}

variable "devops_repository_branch_policy_configuration" {
  type = map(object({
    target_branch = string
    match_type    = string
    minimum_reviewer_configuration = object({
      reviewer_count               = number
      submitter_can_vote           = bool
      last_pusher_cannot_approve   = bool
      on_push_reset_approved_votes = bool
    })
    comment_resolution_configuration = object({
      enabled  = bool
      blocking = bool
    })
    reviewer_configuration = object({
      enabled                     = bool
      blocking                    = bool
      minimum_number_of_reviewers = number
    })
    work_item_configuration = object({
      enabled  = bool
      blocking = bool
    })
  }))
}
