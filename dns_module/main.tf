
resource "null_resource" "aws_cli" {

  provisioner "local-exec" {
    command = join(" ",["aws route53 change-resource-record-sets",
              "--hosted-zone-id ${var.AWS_DNS_ZONE_ID}",
              "--change-batch={\"Changes\":[{\"Action\":\"UPSERT\",\"ResourceRecordSet\":{\"Name\":\"${var.FQDN}\",\"Type\":\"CNAME\",\"TTL\":300,\"ResourceRecords\":[{\"Value\":\"${var.default_hostname}\"}]}}]}"])
  }
  
}

resource "azurerm_app_service_custom_hostname_binding" "hostname-binding" {
  hostname            = var.FQDN
  app_service_name    = var.linux_web_app_name
  resource_group_name = var.resource_group_name # rg where app service exists

  depends_on = [null_resource.aws_cli]
}

resource "azurerm_app_service_managed_certificate" "example" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.hostname-binding.id
}

resource "azurerm_app_service_certificate_binding" "example" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.hostname-binding.id
  certificate_id      = azurerm_app_service_managed_certificate.example.id
  ssl_state           = "SniEnabled"
}