data "azuredevops_group" "code_reviewers_group" {
  name = "Code reviewers"
}

data "azuredevops_group" "contributer_group" {
  project_id = azuredevops_project.project.id
  name       = "Contributors"
}

resource "azuredevops_project" "project" {
  name               = "terraform-test-project"
  visibility         = "private"
  work_item_template = "Scrum"
  description        = "Test terraform"
}

resource "azuredevops_group" "project_client_group" {
  scope        = azuredevops_project.project.id
  display_name = "Test project clients"
  description  = "Client group"
}

resource "azuredevops_project_permissions" "project_client_group_permissions" {
  project_id = azuredevops_project.project.id
  principal  = azuredevops_group.project_client_group.id
  permissions = {
    GENERIC_READ  = "Allow"
    GENERIC_WRITE = "Allow"
  }
}

resource "azuredevops_branch_policy_min_reviewers" "minimum_number_of_reviewers_configuration" {
  project_id = azuredevops_project.project.id
  settings {
    reviewer_count               = 2
    submitter_can_vote           = false
    last_pusher_cannot_approve   = true
    on_push_reset_approved_votes = true

    scope {
      match_type = "DefaultBranch"
    }
  }
}

resource "azuredevops_branch_policy_work_item_linking" "work_item_configuration" {
  project_id = azuredevops_project.project.id
  enabled    = true
  blocking   = true

  settings {
    scope {
      match_type = "DefaultBranch"
    }
  }
}

resource "azuredevops_branch_policy_comment_resolution" "comment_resolution_configuration" {
  project_id = azuredevops_project.project.id
  enabled    = true
  blocking   = true

  settings {
    scope {
      match_type = "DefaultBranch"
    }
  }
}

resource "azuredevops_git_permissions" "default_repository_git_permissions" {
  project_id = azuredevops_project.project.id
  principal  = data.azuredevops_group.contributer_group.id
  permissions = {
    PullRequestBypassPolicy = "Allow"
    ForcePush               = "Allow"
    PolicyExempt            = "Allow"
  }
}

resource "azuredevops_git_permissions" "client_repo_permissions" {
  project_id = azuredevops_project.project.id
  principal  = azuredevops_group.project_client_group.id
  permissions = {
    GenericRead = "Deny"
  }
}

resource "azuredevops_branch_policy_auto_reviewers" "code_reviewers" {
  project_id = azuredevops_project.project.id
  enabled    = true
  blocking   = true
  settings {
    auto_reviewer_ids           = [data.azuredevops_group.code_reviewers_group.origin_id]
    minimum_number_of_reviewers = 2
    scope {
      match_type = "DefaultBranch"
    }
  }
}
