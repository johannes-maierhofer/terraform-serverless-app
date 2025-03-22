variable "subscription_id" {
    description = "Azure subscription id"
    type = string
    default = "8a7ffa5b-f443-4ad1-a051-f12b25e4f87e"
}

variable "project_name" {
  description = "Name of the application, meaning Serverless App"
  default     = "sla"
}

variable "location" {
  description = "Azure region for the resource group"
  default     = "we"
}

variable "env_id" {
  description = "Deployment environment, e.g., dev, test, prod"
  default     = "dev"
}

variable "src_key" {
  type = string
  description = "the infrastructure source"
  default = "terraform"
}
