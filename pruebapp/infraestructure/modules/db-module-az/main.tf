resource "azurerm_postgresql_flexible_server" "DB_OXHE" {
  count                      = length(server_numberid)
  name                       = "${var.short_company}${var.short_cloud}DB${var.short_project}${var.short_env}${var.server_numberid[count.index]}"
  location                   = var.rg_reference.location
  resource_group_name        = var.rg_reference.location
  version                    = var.version
  storage_mb = var.storage_mb
  administrator_login        = var.admin_username[count.index]
  administrator_login_password = var.admin_password[count.index]
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled
  sku_name                   = var.sku_name
  delegated_subnet_id    = azurerm_subnet.private[2].id
  #private_dns_zone_id    = azurerm_private_dns_zone.example.id
  public_network_access_enabled    = var.public_network_access_enabled
}