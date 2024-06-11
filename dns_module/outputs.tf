output "app_service_custom_hostname_binding_app_service_name" {
    value = azurerm_app_service_custom_hostname_binding.hostname-binding.app_service_name
}

output "app_service_custom_hostname_binding_hostname" {
    value = azurerm_app_service_custom_hostname_binding.hostname-binding.hostname
}