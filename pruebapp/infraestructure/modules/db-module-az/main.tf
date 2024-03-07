resource "azurerm_postgresql_server" "DB_OXHE" {
  count                      = length(server_numberid)
  name                       = "${var.short_company}${var.short_cloud}DB${var.short_project}${var.short_env}${var.server_numberid[count.index]}"
  location                   = var.rg_reference.location
  resource_group_name        = var.rg_reference.location
  version                    = "11"
  storage_mb = 500000
  administrator_login        = var.admin_username
  administrator_login_password = var.admin_password
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled
  sku_name                   = "GP_Gen5_2"
  public_network_access_enabled    = false
}