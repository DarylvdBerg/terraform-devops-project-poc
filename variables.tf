variable "project_configuration" {
  type = map(object({
    project_name           = string
    project_description    = string
    project_scrum_template = string
    project_wiki_list = map(object({
      sub_pages = set(string)
    }))
    project_git_permissions = object({
      PullRequestBypassPolicy = optional(string, "Allow")
      ForcePush               = optional(string, "Allow")
      PolicyExempt            = optional(string, "Allow")
    })
    project_client_permissions = object({
      GENERIC_READ  = optional(string, "Allow")
      GENERIC_WRITE = optional(string, "Allow")
    })
    project_branch_policy_configuration = map(object({
      target_branch = string
      match_type    = string
      minimum_reviewer_configuration = object({
        reviewer_count               = optional(number, 2)
        submitter_can_vote           = optional(bool, true)
        last_pusher_cannot_approve   = optional(bool, false)
        on_push_reset_approved_votes = optional(bool, true)
      })
      comment_resolution_configuration = object({
        enabled  = optional(bool, true)
        blocking = optional(bool, true)
      })
      reviewer_configuration = object({
        enabled                     = optional(bool, true)
        blocking                    = optional(bool, true)
        minimum_number_of_reviewers = optional(number, 2)
      })
      work_item_configuration = object({
        enabled  = optional(bool, true)
        blocking = optional(bool, true)
      })
    }))
  }))
}
