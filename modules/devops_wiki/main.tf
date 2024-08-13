resource "azuredevops_wiki" "project_wiki" {
  name       = "${var.project_name} Wiki"
  project_id = var.project_id
  type       = "projectWiki"
}

// TODO: Implement pages once feature is finished