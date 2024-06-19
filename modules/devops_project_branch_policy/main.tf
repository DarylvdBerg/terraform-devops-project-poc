resource "azuredevops_branch_policy_min_reviewers" "minimum_number_of_reviewers_configuration" {
  project_id = var.devops_project_id
  settings {
    reviewer_count               = var.devops_repository_branch_policy_minimum_reviewer_configuration.reviewer_count
    submitter_can_vote           = var.devops_repository_branch_policy_minimum_reviewer_configuration.submitter_can_vote
    last_pusher_cannot_approve   = var.devops_repository_branch_policy_minimum_reviewer_configuration.last_pusher_cannot_approve
    on_push_reset_approved_votes = var.devops_repository_branch_policy_minimum_reviewer_configuration.on_push_reset_approved_votes

    scope {
      repository_ref = var.devops_repository_branch_policy_target
      match_type     = var.devops_repository_branch_match_type
    }
  }
}

resource "azuredevops_branch_policy_comment_resolution" "comment_resolution_configuration" {
  project_id = var.devops_project_id
  enabled    = var.devops_repository_branch_policy_comment_resolution_configuration.enabled
  blocking   = var.devops_repository_branch_policy_comment_resolution_configuration.blocking

  settings {
    scope {
      repository_ref = var.devops_repository_branch_policy_target
      match_type     = var.devops_repository_branch_match_type
    }
  }
}

resource "azuredevops_branch_policy_auto_reviewers" "code_reviewers" {
  project_id = var.devops_project_id
  enabled    = var.devops_repository_branch_policy_reviewer_configuration.enabled
  blocking   = var.devops_repository_branch_policy_reviewer_configuration.blocking

  settings {
    auto_reviewer_ids           = [var.devops_project_contributor_group_id]
    minimum_number_of_reviewers = var.devops_repository_branch_policy_reviewer_configuration.minimum_number_of_reviewers
    scope {
      repository_ref = var.devops_repository_branch_policy_target
      match_type     = var.devops_repository_branch_match_type
    }
  }
}

resource "azuredevops_branch_policy_work_item_linking" "work_item_configuration" {
  project_id = var.devops_project_id
  enabled    = var.devops_repository_branch_policy_work_item_link_configuration.enabled
  blocking   = var.devops_repository_branch_policy_work_item_link_configuration.blocking

  settings {
    scope {
      repository_ref = var.devops_repository_branch_policy_target
      match_type     = var.devops_repository_branch_match_type
    }
  }
}
