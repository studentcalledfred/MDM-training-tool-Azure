
############################################################################################
#######################      DNS MODULE VARIABLES      ########################
############################################################################################

variable "custom_url" {
  type        = string
  description = "The custom url name of our mdm website"
}

variable "azure_dns_zone" {
  type        = string
  description = "The Azure DNS zone name"
  default     = "mdmce06app.com"
}

variable "dns_ttl" {
  type        = number
  default     = 3600
  description = "Time to live (TTL) of DNS record in secs"
}

variable "FQDN" {
  type = string
}

variable "AWS_DNS_ZONE_ID" {
  type = string
}
############################################################################################
#######################      DEFAULT TAGS AND NAMING VAIRALBES      ########################
############################################################################################

variable "cohort" {
  type    = string
  default = "ce06"
}

variable "env" {
  type    = list(string)
  default = ["dev"]
}

variable "owner" {
  type    = string
  default = "mdm_tf_team"
}

variable "project_name" {
  type    = string
  default = "mdm"
}

variable "location_abrv" {
  type    = string
  default = "uks"
}

############################################################################################
##############################      APP VARIABLES     ######################################
############################################################################################

variable "pricing_plan" {
  type    = string
  default = "P0v3"
}

variable "python_version" {
  type    = string
  default = "3.10"
}

variable "location" {
  type    = string
  default = "UK South"
}








