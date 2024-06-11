data "azurerm_resource_group" "target" {
  name = var.resource_group
}


resource "azurerm_cosmosdb_account" "account" {
  name                = local.cosmosdb_account_name
  location            = data.azurerm_resource_group.target.location
  resource_group_name = data.azurerm_resource_group.target.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"


  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  geo_location {
    location          = var.backup_location
    failover_priority = 1
  }

  tags = local.default_tags
}


resource "azurerm_cosmosdb_sql_database" "database" {
  name                = local.cosmosdb_sql_database
  resource_group_name = data.azurerm_resource_group.target.name
  account_name        = azurerm_cosmosdb_account.account.name
}


resource "azurerm_cosmosdb_sql_container" "container" {
  name                = local.cosmosdb_sql_container
  resource_group_name = data.azurerm_resource_group.target.name
  account_name        = azurerm_cosmosdb_account.account.name
  database_name       = azurerm_cosmosdb_sql_database.database.name
  partition_key_path  = "/id"
  throughput          = 400
}

