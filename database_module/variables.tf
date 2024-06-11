############################################################################################
#######################      DEFAULT TAGS AND NAMING VAIRALBES      ########################
############################################################################################


variable "cohort" {
  type    = string
}

variable "owner" {
  type    = string
}

variable "project_name" {
  type    = string
}


############################################################################################
##############################      RESOURCE GROUP    ######################################
############################################################################################


variable "location" {
  type    = string
}

variable "backup_location" {
  type    = string
  default = "westeurope"
}

variable "resource_group" {
  type    = string
}
