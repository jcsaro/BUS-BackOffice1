resource "azurerm_service_plan" "app_service_plan_OXH" {
  name                = "${var.short_company}${var.short_cloud}ASP${var.short_project}${var.short_env}${var.resource_number}"
  resource_group_name = var.rg_reference.name
  location            = var.rg_reference.location
  sku_name            = "P1v2"
  os_type             = "Linux"
}
