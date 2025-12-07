variable "prefix" {
  type    = string
  default = "studentdemo"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "resource_group_name" {
  type    = string
  default = "rg-studentdemo"
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "app_service_sku" {
  type    = string
  default = "B1"
}

variable "app_service_worker_count" {
  type    = number
  default = 1
}
variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}
