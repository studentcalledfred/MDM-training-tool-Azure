data "azurerm_client_config" "name" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.default_tags
}

# Creates the service plan and isolates the resources necesarry for the web app to run,
# hardoded for Linux to support streamlit apps

resource "azurerm_service_plan" "applan" {
  name                = local.appplan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = var.pricing_plan
  tags                = local.default_tags
}

# creates the application registration in order to allow authorization through Azure Active Directory
resource "azuread_application" "name" {
  display_name = local.app_rg_name
  # Will set the owner to the current objects id, in local a person, in terraform only the pipeline
  # Can expand list to include specific users or group ids to give administrators permissions to modify
  # on portal
  owners = [data.azurerm_client_config.name.object_id]
  web {
    redirect_uris = [format("https://%s.azurewebsites.net/.auth/login/aad/callback", local.webapp_name),
                     format("https://%s/.auth/login/aad/callback",var.FQDN)]

    # Adds website configuration to request and get tokens from microsoft provider
    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

}

resource "azurerm_linux_web_app" "webapp" {
  name                = local.webapp_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.applan.id
  https_only          = true

  # Only allows authorization from accounts matching current tenant id
  app_settings = {
    "WEBSITE_AUTH_AAD_ALLOWED_TENANTS" = data.azurerm_client_config.name.tenant_id
  }
  # Configures the site to use python and run a startup command
  site_config {
    app_command_line = "python -m streamlit run MDM_Tool_Intro.py --server.port 8000 --server.address 0.0.0.0"
    application_stack {
      python_version = var.python_version
    }

  }

  auth_settings_v2 {
    auth_enabled           = true
    require_authentication = true
    unauthenticated_action = "RedirectToLoginPage"

    login {
      token_store_enabled = true
    }

    active_directory_v2 {
      # Only allows requests to be made from application itself
      allowed_applications = [
        azuread_application.name.client_id,
      ]

      # attatches application registration to the app itself, providing an authentication provider
      client_id                  = azuread_application.name.client_id
      client_secret_setting_name = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"

      # allows authentication through the azure directory by redirecting traffic to endpoint
      tenant_auth_endpoint = format("https://sts.windows.net/%s/v2.0", data.azurerm_client_config.name.tenant_id)
    }
  }
  tags = local.default_tags
}
# slots to act as stages of development in pipeline
resource "azurerm_linux_web_app_slot" "slots" {
  depends_on = [azurerm_linux_web_app.webapp]

  # iterates through environment list and creates as many slots respectivley with names repsective to environment
  count          = length(var.env)
  app_service_id = azurerm_linux_web_app.webapp.id
  name           = element(var.env[*], count.index)

  site_config {
    app_command_line = "python -m streamlit run MDM_Tool_Intro.py --server.port 8000 --server.address 0.0.0.0"
    application_stack {
      python_version = var.python_version
    }

  }
  auth_settings_v2 {
    auth_enabled           = true
    require_authentication = true
    unauthenticated_action = "RedirectToLoginPage"
    login {
      token_store_enabled = true
    }
    active_directory_v2 {
      # connects to azure active directory through the applicaiton registry created previously
      client_id                  = azuread_application.name.client_id
      client_secret_setting_name = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
      tenant_auth_endpoint       = format("https://sts.windows.net/%s/v2.0", data.azurerm_client_config.name.tenant_id)
    }
  }
  tags = local.default_tags
}