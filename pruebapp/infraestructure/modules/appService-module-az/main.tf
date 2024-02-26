locals {
  app_settings_variables = {      
      
      "APPLICATION_NAME" : var.webapp_name
      "SERVICE_PORT": "8080"
      "WEBSITES_CONTAINER_START_TIME_LIMIT": "500"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE": "false" 
      "WEBSITES_PORT": "8080"
      "WEBSITE_ENABLE_SYNC_UPDATE_SITE": "true"
      "APPINSIGHTS_INSTRUMENTATIONKEY" : var.appinsights_intrumentation_key
      "APPLICATIONINSIGHTS_CONNECTION_STRING" : var.appinsights_connection_string
      
      "ApplicationInsightsAgent_EXTENSION_VERSION" : "~3"
    }
}

resource "azurerm_linux_web_app" "webapp-linux" {
  name                = "asv${var.principal_resource_location_acronym}${var.environment}${var.webapp_name}"
  resource_group_name = var.resource_group_name
  location            = var.principal_resource_location
  service_plan_id     = var.service_plan_id

  virtual_network_subnet_id = var.enable_subnet_integration && var.subnet_id != null ? var.subnet_id : null
    
  site_config {
    always_on = var.always_on 
    health_check_path = "/${var.webapp_name}/actuator/health"
    minimum_tls_version = 1.2
    application_stack {
      docker_image_name = "${var.image_name}:latest"
      docker_registry_url = "https://${var.container_registry_loginserver}"
      docker_registry_username = var.container_registry_user
      docker_registry_password = "@Microsoft.KeyVault(SecretUri=${var.container_registry_pwd})"

    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? [1] : []
      content {
              service_tag               = "AzureFrontDoor.Backend"
              ip_address                = null
              virtual_network_subnet_id = null
              action                    = "Allow"
              priority                  = 100
              headers {
                x_azure_fdid      = [var.cdn_front_door_guid]
                x_fd_health_probe = []
                x_forwarded_for   = []
                x_forwarded_host  = []
              }
              name = "Allow traffic from Front Door"
      }
    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? var.subnets : []
      content {
              service_tag               = null
              ip_address                = null
              virtual_network_subnet_id = ip_restriction.value
              action                    = "Allow"
              priority                  = 200
              name = "Allow microservices subnet"
      }
    }
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 0 
        retention_in_mb   = 50
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(local.app_settings_variables)

  tags = var.tags_mandatory
  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"],
      #site_config[0].application_stack[0], #change if you need update de container access parameters
      site_config[0].application_stack[0].docker_image_name,
      tags["creationDate"]
    ]
  }
}

resource "azurerm_linux_web_app" "webapp-linux-secondary" {
  count = var.enable_hight_availability == true ? 1 : 0
  name                = "asv${var.secondary_resource_location_acronym}${var.environment}${var.webapp_name}secondary"
  resource_group_name = var.resource_group_name
  location            = var.secondary_resource_location
  service_plan_id     = var.secondary_service_plan_id

  virtual_network_subnet_id = var.enable_subnet_integration && var.subnet_secondary_id != null ? var.subnet_secondary_id : null
    
  site_config {
    always_on = var.always_on 
    health_check_path = "/${var.webapp_name}/actuator/health"
    minimum_tls_version = 1.2
    application_stack {
      docker_image_name = "${var.image_name}:latest"
      docker_registry_url = "https://${var.container_registry_loginserver}"
      docker_registry_username = var.container_registry_user
      docker_registry_password = "@Microsoft.KeyVault(SecretUri=${var.container_registry_pwd})"

    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? [1] : []
      content {
              service_tag               = "AzureFrontDoor.Backend"
              ip_address                = null
              virtual_network_subnet_id = null
              action                    = "Allow"
              priority                  = 100
              headers {
                x_azure_fdid      = [var.cdn_front_door_guid]
                x_fd_health_probe = []
                x_forwarded_for   = []
                x_forwarded_host  = []
              }
              name = "Allow traffic from Front Door"
      }
    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? var.subnets_secondary : []
      content {
              service_tag               = null
              ip_address                = null
              virtual_network_subnet_id = ip_restriction.value
              action                    = "Allow"
              priority                  = 200
              name = "Allow microservices subnet"
      }
    }
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 0 
        retention_in_mb   = 50
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(local.app_settings_variables)

  tags = var.tags_mandatory
  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"],
      #site_config[0].application_stack[0], #change if you need update de container access parameters
      site_config[0].application_stack[0].docker_image_name,
      tags["creationDate"]
    ]
  }
}

#access IaC keyvault access to key vault
resource "azurerm_key_vault_access_policy" "ap-app-accesscontrol" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_linux_web_app.webapp-linux.identity[0].principal_id

  secret_permissions = [
      "Set", "Get", "List"
    ] 
}

resource "azurerm_key_vault_access_policy" "ap-app-accesscontrol-secondary" {
  count = var.enable_hight_availability  == true ? 1 : 0
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_linux_web_app.webapp-linux-secondary[0].identity[0].principal_id

  secret_permissions = [
      "Set", "Get", "List"
    ] 
}

resource "azurerm_linux_web_app_slot" "webapp-slot-versions" {
  count = var.number_slots_versions
  name           = "version${count.index}"
  app_service_id = azurerm_linux_web_app.webapp-linux.id 

  virtual_network_subnet_id = var.enable_subnet_integration && var.subnet_id != null ? var.subnet_id : null

  site_config {
    #vnet_route_all_enabled = true
    always_on = var.always_on 
    health_check_path = "/${var.webapp_name}/actuator/health"
    minimum_tls_version = 1.2
    application_stack {
      docker_image_name = "${var.image_name}:latest"
      docker_registry_url = "https://${var.container_registry_loginserver}"
      docker_registry_username = var.container_registry_user
      docker_registry_password = "@Microsoft.KeyVault(SecretUri=${var.container_registry_pwd})"

    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? [1] : []
      content {
              service_tag               = "AzureFrontDoor.Backend"
              ip_address                = null
              virtual_network_subnet_id = null
              action                    = "Allow"
              priority                  = 100
              headers {
                x_azure_fdid      = [var.cdn_front_door_guid]
                x_fd_health_probe = []
                x_forwarded_for   = []
                x_forwarded_host  = []
              }
              name = "Allow traffic from Front Door"
      }
    }
      dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? var.subnets : []
      content {
              service_tag               = null
              ip_address                = null
              virtual_network_subnet_id = ip_restriction.value
              action                    = "Allow"
              priority                  = 200
              name = "Allow microservices subnet"
      }
    }
  }

  app_settings = merge(local.app_settings_variables)

  identity {
    type = "SystemAssigned"
  }


   logs {
    http_logs {
      file_system {
        retention_in_days = 0 
        retention_in_mb   = 50
      }
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"],
      site_config["application_stack"],
      tags["creationDate"]
    ]
  }
  depends_on = [ azurerm_linux_web_app.webapp-linux ]
}

resource "azurerm_key_vault_access_policy" "ap-app-accesscontrol-slot-versions" {
  count = var.number_slots_versions
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_linux_web_app_slot.webapp-slot-versions[count.index].identity[0].principal_id

  secret_permissions = [
      "Set", "Get", "List"
    ] 
}

resource "azurerm_linux_web_app_slot" "webapp-slot" {
  count = var.create_appservice_slot == true ? 1 : 0
  name           = "staging"
  app_service_id = azurerm_linux_web_app.webapp-linux.id 

  virtual_network_subnet_id = var.enable_subnet_integration && var.subnet_id != null ? var.subnet_id : null

  site_config {
    always_on = var.always_on 
    health_check_path = "/${var.webapp_name}/actuator/health"
    minimum_tls_version = 1.2
    #vnet_route_all_enabled = true
    application_stack {
      docker_image_name = "${var.image_name}:latest"
      docker_registry_url = "https://${var.container_registry_loginserver}"
      docker_registry_username = var.container_registry_user
      docker_registry_password = "@Microsoft.KeyVault(SecretUri=${var.container_registry_pwd})"

    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? [1] : []
      content {
              service_tag               = "AzureFrontDoor.Backend"
              ip_address                = null
              virtual_network_subnet_id = null
              action                    = "Allow"
              priority                  = 100
              headers {
                x_azure_fdid      = [var.cdn_front_door_guid]
                x_fd_health_probe = []
                x_forwarded_for   = []
                x_forwarded_host  = []
              }
              name = "Allow traffic from Front Door"
      }
    }
      dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? var.subnets : []
      content {
              service_tag               = null
              ip_address                = null
              virtual_network_subnet_id = ip_restriction.value
              action                    = "Allow"
              priority                  = 200
              name = "Allow microservices subnet"
      }
    }
  }

  app_settings = merge(local.app_settings_variables)

  identity {
    type = "SystemAssigned"
  }


   logs {
    http_logs {
      file_system {
        retention_in_days = 0 
        retention_in_mb   = 50
      }
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"],
      site_config["application_stack"],
      tags["creationDate"]
    ]
  }
  depends_on = [ azurerm_linux_web_app.webapp-linux ]
}

resource "azurerm_key_vault_access_policy" "ap-app-accesscontrol-slot" {
  count = var.create_appservice_slot == true ? 1 : 0
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_linux_web_app_slot.webapp-slot[0].identity[0].principal_id

  secret_permissions = [
      "Set", "Get", "List"
    ] 
}

resource "azurerm_linux_web_app_slot" "webapp-slot-secondary" {
  count = var.enable_hight_availability && var.create_appservice_slot ? 1 : 0
  name           = "staging"
  app_service_id = azurerm_linux_web_app.webapp-linux-secondary[0].id 

  virtual_network_subnet_id = var.enable_subnet_integration && var.subnet_secondary_id != null ? var.subnet_secondary_id : null

  site_config {
    always_on = var.always_on 
    health_check_path = "/${var.webapp_name}/actuator/health"
    minimum_tls_version = 1.2
    #vnet_route_all_enabled = true
    application_stack {
      docker_image_name = "${var.image_name}:latest"
      docker_registry_url = "https://${var.container_registry_loginserver}"
      docker_registry_username = var.container_registry_user
      docker_registry_password = "@Microsoft.KeyVault(SecretUri=${var.container_registry_pwd})"

    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? [1] : []
      content {
              service_tag               = "AzureFrontDoor.Backend"
              ip_address                = null
              virtual_network_subnet_id = null
              action                    = "Allow"
              priority                  = 100
              headers {
                x_azure_fdid      = [var.cdn_front_door_guid]
                x_fd_health_probe = []
                x_forwarded_for   = []
                x_forwarded_host  = []
              }
              name = "Allow traffic from Front Door"
      }
    }
    dynamic  "ip_restriction" {
      for_each = var.enable_hight_availability ? var.subnets_secondary : []
      content {
              service_tag               = null
              ip_address                = null
              virtual_network_subnet_id = ip_restriction.value
              action                    = "Allow"
              priority                  = 200
              name = "Allow microservices subnet"
      }
    }
  }

  app_settings = merge(local.app_settings_variables)

  identity {
    type = "SystemAssigned"
  }


   logs {
    http_logs {
      file_system {
        retention_in_days = 0 
        retention_in_mb   = 50
      }
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"],
      site_config["application_stack"],
      tags["creationDate"]
    ]
  }
  depends_on = [ azurerm_linux_web_app.webapp-linux ]
}

resource "azurerm_key_vault_access_policy" "ap-app-accesscontrol-slot-secondary" {
  count = var.create_appservice_slot == true ? 1 : 0
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_linux_web_app_slot.webapp-slot-secondary[0].identity[0].principal_id

  secret_permissions = [
      "Set", "Get", "List"
    ] 
}


locals {
  api_management_enabled = var.api_management_name != null
}

data "template_file" "api_definition" {
  template = file("../default_api_definition.json") 
}

resource "azurerm_api_management_api" "app_service_api" {
  count = local.api_management_enabled == true ? 1 : 0

  name                = var.name_microservices_api
  resource_group_name = var.api_management_resource_group_name
  api_management_name = var.api_management_name

  revision      = "1"
  display_name  = var.name_microservices_api
  description   = "This is the API for ${var.name_microservices_api} published in API Management."
  subscription_required = false

  path = var.name_microservices_api
  protocols = ["https"]

  service_url = var.enable_hight_availability ? "https://${var.frontdoor_endpoint_url}/${var.webapp_name}" : "https://${azurerm_linux_web_app.webapp-linux.default_hostname}/${var.webapp_name}" 

  import {
    content_format = "openapi"
    content_value  = data.template_file.api_definition.rendered #use a default api and add the real in the pipeline
  }

  lifecycle {
    ignore_changes = [ import[0],
                       description]
  }
}

resource "azurerm_api_management_product" "app_service_product" {
  count = local.api_management_enabled == true ? 1 : 0

  product_id          = var.webapp_name
  description = "product for the ${var.webapp_name} service"
  display_name = var.webapp_name
  resource_group_name = var.api_management_resource_group_name
  api_management_name = var.api_management_name
  subscription_required = false
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_product_api" "app_service_product_api" {
  count = local.api_management_enabled == true ? 1 : 0

  api_name              = azurerm_api_management_api.app_service_api[0].name
  product_id            = azurerm_api_management_product.app_service_product[0].product_id  
  api_management_name   = var.api_management_name
  resource_group_name   = var.api_management_resource_group_name
}

resource "azurerm_api_management_product_api" "app_service_full_api_product" {
  count = local.api_management_enabled == true ? 1 : 0

  api_name              = azurerm_api_management_api.app_service_api[0].name
  product_id            = var.full_api_product 
  api_management_name   = var.api_management_name
  resource_group_name   = var.api_management_resource_group_name
}

resource "azurerm_cdn_frontdoor_origin_group" "cdn_origin_group" {
  count = var.enable_hight_availability ? 1 : 0
  name                     = var.webapp_name
  cdn_frontdoor_profile_id = var.frontdoor_microservices_id
  session_affinity_enabled = false

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0

  health_probe {
    interval_in_seconds = 60
    path                = "/${var.webapp_name}/actuator/health"
    protocol            = "Https"
    request_type        = "GET"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 3
    successful_samples_required        = 2
  }

}

resource "azurerm_cdn_frontdoor_origin" "cdn_origin" {
  count = var.enable_hight_availability ? 1 : 0
  name                          = var.webapp_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_origin_group[0].id
  enabled                       = true

  certificate_name_check_enabled = true

  host_name          = azurerm_linux_web_app.webapp-linux.default_hostname 
  origin_host_header = azurerm_linux_web_app.webapp-linux.default_hostname
  http_port          = 80
  https_port         = 443
  priority           = 1
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_origin" "cdn_origin_secondary" {
  count = var.enable_hight_availability ? 1 : 0
  name                          = "${var.webapp_name}secondary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_origin_group[0].id
  enabled                       = true

  certificate_name_check_enabled = true

  host_name          = azurerm_linux_web_app.webapp-linux-secondary[0].default_hostname
  origin_host_header = azurerm_linux_web_app.webapp-linux-secondary[0].default_hostname
  http_port          = 80
  https_port         = 443
  priority           = 2
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_route" "default-route" {
  count = var.enable_hight_availability ? 1 : 0
  name                          = "default-route-${var.webapp_name}"
  cdn_frontdoor_endpoint_id     = var.frontdoor_endpoint_id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_origin_group[0].id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.cdn_origin[0].id,azurerm_cdn_frontdoor_origin.cdn_origin_secondary[0].id]
  cdn_frontdoor_custom_domain_ids = []
  cdn_frontdoor_rule_set_ids = []  
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/${var.webapp_name}/*"]
  supported_protocols    = ["Http", "Https"]

  link_to_default_domain          = true

  #cache {
  #  query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
  #  query_strings                 = ["account", "settings"]
  #  compression_enabled           = true
  #  content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
  #}
}