terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
provider "azuread" {}

module "streamlit_app" {
  source         = "./webapp_module"
  location       = var.location
  owner          = var.owner
  cohort         = var.cohort
  env            = var.env
  project_name   = var.project_name
  pricing_plan   = var.pricing_plan
  location_abrv  = var.location_abrv
  python_version = var.python_version
  FQDN           = var.FQDN
}

module "custom_dns" {
  depends_on                    = [module.streamlit_app]
  source                        = "./dns_module"
  cohort                        = var.cohort
  owner                         = var.owner
  resource_group_name           = module.streamlit_app.resource_group_name
  project_name                  = var.project_name
  location                      = var.location
  custom_domain_verification_id = module.streamlit_app.custom_domain_verification_id
  default_hostname              = module.streamlit_app.default_hostname
  linux_web_app_name            = module.streamlit_app.web_app_name
  FQDN                          = var.FQDN
  AWS_DNS_ZONE_ID               = var.AWS_DNS_ZONE_ID

}

