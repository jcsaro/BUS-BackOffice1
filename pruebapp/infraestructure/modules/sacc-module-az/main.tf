resource "azurerm_storage_account" "acc" {
  name                     = "${var.short_company}${var.short_cloud}STA${var.short_project}${var.short_env}WS${var.resource_number}"
  resource_group_name      = var.rg_reference.name
  location                 = var.rg_reference.location
  account_tier             = var.storage_tier
  account_replication_type = var.storage_redundancy
}