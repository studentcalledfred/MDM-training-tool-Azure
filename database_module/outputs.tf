output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.account.name
}

output "cosmosdb_account_uri" {
  value = azurerm_cosmosdb_account.account.endpoint
}

output "cosmosdb_database_name" {
  value = azurerm_cosmosdb_sql_database.database.name
}

output "cosmosdb_container_name" {
  value = azurerm_cosmosdb_sql_container.container.name
}

output "cosmosdb_connection_string" {
  value = azurerm_cosmosdb_account.account.primary_sql_connection_string
  sensitive = true
}



