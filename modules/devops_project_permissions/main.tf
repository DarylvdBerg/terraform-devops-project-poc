# Permissions
resource "azuredevops_git_permissions" "default_repository_git_permissions" {
  project_id  = var.project_id
  principal   = var.project_contributors_group_id
  permissions = var.devops_project_repository_git_permissions
}

resource "azuredevops_project_permissions" "project_client_group_permissions" {
  project_id  = var.project_id
  principal   = var.project_client_group_id
  permissions = var.devops_project_client_group_permissions
}

resource "azuredevops_git_permissions" "client_repo_permissions" {
  project_id = var.project_id
  principal  = var.project_client_group_id
  permissions = {
    GenericRead = "Deny"
  }
}