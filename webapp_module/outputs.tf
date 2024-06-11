output "web_app_name" {
  value = azurerm_linux_web_app.webapp.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "slot_name" {
  value = azurerm_linux_web_app_slot.slots.*.name
}

output "default_hostname" {
  value = azurerm_linux_web_app.webapp.default_hostname
}

output "service_plan_name" {
  value = azurerm_service_plan.applan.name
}

output "custom_domain_verification_id" {
  value = azurerm_linux_web_app.webapp.custom_domain_verification_id
}