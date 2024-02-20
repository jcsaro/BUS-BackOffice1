resource "azurerm_key_vault" "example" {
  name                        = "${var.short_company}${var.short_cloud}KV${var.short_company}HD${var.resource_number}"
  resource_group_name         = var.rg_reference.name
  location                    = var.rg_reference.location
  sku_name                    = var.sku
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}