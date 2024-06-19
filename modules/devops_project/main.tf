data "azuredevops_group" "contributer_group" {
  project_id = azuredevops_project.project.id
  name       = "Contributors"
}

# Project
resource "azuredevops_project" "project" {
  name               = var.devops_project_name
  visibility         = "private"
  work_item_template = var.devops_project_scrum_template
  description        = var.devops_project_description
}

# Groups
resource "azuredevops_group" "project_client_group" {
  scope        = azuredevops_project.project.id
  display_name = "${var.devops_project_name} clients"
  description  = "${var.devops_project_name} client group"
}

# Permissions
resource "azuredevops_git_permissions" "default_repository_git_permissions" {
  project_id  = azuredevops_project.project.id
  principal   = data.azuredevops_group.contributer_group.id
  permissions = var.devops_project_repository_git_permissions
}

resource "azuredevops_project_permissions" "project_client_group_permissions" {
  project_id  = azuredevops_project.project.id
  principal   = azuredevops_group.project_client_group.id
  permissions = var.devops_project_client_group_permissions
}

resource "azuredevops_git_permissions" "client_repo_permissions" {
  project_id = azuredevops_project.project.id
  principal  = azuredevops_group.project_client_group.id
  permissions = {
    GenericRead = "Deny"
  }
}

module "branch_policies" {
  source                                                           = "../devops_project_branch_policy"
  for_each                                                         = var.devops_repository_branch_policy_configuration
  devops_project_id                                                = azuredevops_project.project.id
  devops_project_contributor_group_id                              = data.azuredevops_group.contributer_group.origin_id
  devops_repository_branch_policy_target                           = each.value.target_branch
  devops_repository_branch_match_type                              = each.value.match_type
  devops_repository_branch_policy_reviewer_configuration           = each.value.reviewer_configuration
  devops_repository_branch_policy_work_item_link_configuration     = each.value.work_item_configuration
  devops_repository_branch_policy_comment_resolution_configuration = each.value.comment_resolution_configuration
  devops_repository_branch_policy_minimum_reviewer_configuration   = each.value.minimum_reviewer_configuration
}
