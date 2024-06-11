
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
##############################      RESOURCE GROUP    ######################################
############################################################################################

variable "location" {
  type    = string
  default = "UK South"
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

variable "FQDN" {
  type = string
}
