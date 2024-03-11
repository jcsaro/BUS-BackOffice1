resource "azurerm_postgresql_flexible_server" "DBOXHE" {
  count                      = length(var.server_numberid)
  name                       = "${var.short_company}${var.short_cloud}DB${var.short_project}${var.short_env}${var.server_numberid[count.index]}"
  location                   = var.rg_reference.location
  resource_group_name        = var.rg_reference.location
  version                    = var.db_version
  storage_mb = var.storage_mb
  administrator_login        = var.admin_username[count.index]
  administrator_password = var.admin_password[count.index]
  sku_name                   = var.sku_name
  delegated_subnet_id    = var.delegated_subnet_id
  #public_network_access_enabled    = var.public_network_access_enabled
}