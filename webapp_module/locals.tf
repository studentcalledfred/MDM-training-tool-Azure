locals {

  rg_name      = format("%s-rg-%s-%s", var.project_name, var.location_abrv, var.cohort)
  appplan_name = format("%s-appSplan-%s-%s", var.project_name, var.location_abrv, var.cohort)
  webapp_name  = format("%s-webapp-%s-%s", var.project_name, var.location_abrv, var.cohort)

  app_rg_name = format("%s-webapp-%s-%s-auth", var.project_name, var.location_abrv, var.cohort)

  default_tags = tomap({
    "cohort"   = var.cohort
    "project"  = var.project_name
    "owner"    = var.owner
    "location" = var.location
  })
}