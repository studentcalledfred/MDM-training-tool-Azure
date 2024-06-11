module "azure_web_app" {
  source            = "../."
  cohort            = var.cohort
  env               = var.env
  location_abrv     = var.location_abrv
  owner             = var.owner
  pricing_plan      = var.pricing_plan
  project_name      = var.project_name
  python_version    = var.python_version
  location          = var.location
  FQDN              = var.FQDN
}
#####################################
####      Example of tfvars      ####
#####################################
# cohort = "ce06"                   
# env = [                           
#   "dev"                           
# ]                                 
# location       = "UK South"       
# location_abrv  = "uks"            
# owner          = "mdm_tf_team"    
# pricing_plan   = "P0v3"          
# project_name   = "mdm"            
# python_version = "3.10"           
# FQDN           = "mdm.kubrickgroup.training"
#####################################