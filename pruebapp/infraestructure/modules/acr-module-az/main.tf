resource "azurerm_container_registry" "acr" {
  name                = "${var.short_company}${var.short_cloud}ACR${var.short_company}HD${var.resource_number}"
  resource_group_name = var.rg_reference.name
  location            = var.rg_reference.location
  sku                 = var.sku
  admin_enabled       = true
}
