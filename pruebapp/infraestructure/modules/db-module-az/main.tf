resource "azurerm_postgresql_flexible_server" "DBOXHE" {
  count                      = length(var.server_numberid)
  name                       = "${var.short_company}${var.short_cloud}DB${var.short_project}${var.short_env}${var.server_numberid[count.index]}"
  location                   = var.rg_reference.location
  resource_group_name        = var.rg_reference.name
  version                    = var.db_version
  storage_mb = var.storage_mb
  administrator_login        = var.admin_username[count.index]
  administrator_password = var.admin_password[count.index]
  sku_name                   = var.sku_name
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.dnszone[count.index]
  #public_network_access_enabled    = var.public_network_access_enabled
}

resource "azurerm_private_dns_zone" "dnszone" {
  count = length(var.server_numberid)
  name                = "OXXO${var.server_numberid[count.index]}.postgres.database.azure.com"
  resource_group_name = var.rg_reference.name
}