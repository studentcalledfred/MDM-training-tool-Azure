
variable "location" {
    type = string
    description = "The location for all resources"
}

variable "dns_ttl" {
    type = number
    default = 3600
    description = "Time to live (TTL) of DNS record in secs"
}

variable "project_name" {
    type = string
    description = "The name of our project"
}

variable "cohort" {
    type = string
    description = "Our cohort number"
}

variable "owner" {
    type = string
    description = "The name of the owner of this project"
}

variable "resource_group_name" {
    type = string
    description = "The name of the rg this project lives in"
}

variable "linux_web_app_name" {
    type = string
    description = "The Linux web app name"
}

variable "custom_domain_verification_id" {
  type = string
  description = "ID of the custome domain verification"
}

variable "default_hostname" {
  type = string
  description = "Default hostname"
}

variable "FQDN" {
  type  = string
}

variable "AWS_DNS_ZONE_ID" {
  type = string
}