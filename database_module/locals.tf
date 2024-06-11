locals {
  target_resource_group  = format("%s-rg-%s-%s", var.project_name, var.location, var.cohort)
  cosmosdb_account_name  = format("%s-cosmosdb-%s-%s", var.project_name, var.location, var.cohort)
  cosmosdb_sql_database  = format("%s-cosmosdb-sql-%s-%s", var.project_name, var.location, var.cohort)
  cosmosdb_sql_container = format("%s-cosmosdb-container-%s-%s", var.project_name, var.location, var.cohort)

  default_tags = tomap({
    "cohort"   = var.cohort
    "project"  = var.project_name
    "owner"    = var.owner
    "location" = var.location
  })
}

