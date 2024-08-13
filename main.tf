module "devops_projects" {
  source   = "./modules/devops_project"
  for_each = var.project_configuration

  devops_project_name                           = each.value.devops_project_name
  devops_project_wiki_pages_list                     = each.value.devops_project_pages_list
  devops_project_description                    = each.value.project_description
  devops_project_scrum_template                 = each.value.project_scrum_template
  devops_project_repository_git_permissions     = each.value.project_git_permissions
  devops_project_client_group_permissions       = each.value.project_client_permissions
  devops_repository_branch_policy_configuration = each.value.project_branch_policy_configuration
}
