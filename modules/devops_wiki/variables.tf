variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "project_pages_list" {
  type = map(object({
    sub_pages = set(string)
  }))
}