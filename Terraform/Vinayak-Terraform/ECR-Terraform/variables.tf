variable "project_name" {
  type = string
}

variable "ecr_name" {
  default = ["admin-panel", "app", "node-backend", "node-admin", "node", "node-notifications", "node-statics", "prize-distribution", "node-user-informations", "node-payments"]
}

# variable "ecr_name" {
#   default = ["article", "authentication", "career", "gateway", "global-widget", "help", "matchmanagement", "migrations", "seo", "subscription", "website", "admin-frontend"]
# }