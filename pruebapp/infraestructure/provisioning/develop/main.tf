module "rgshare" {
  source          = "../../modules/rg-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  resource_number = "01"
}

module "acrShared" {
  source          = "../../modules/acr-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  resource_number = "01"
  rg_reference = {
    name     = module.rgshare.rgName
    location = module.rgshare.rgLocation
  }
}

module "stacc" {
  source          = "../../modules/sacc-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  resource_number = "01"
  rg_reference = {
    name     = module.rgshare.rgName
    location = module.rgshare.rgLocation
  }
}

module "keyvault" {
  source          = "../../modules/kvault-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  resource_number = "01"
  rg_reference = {
    name     = module.rgshare.rgName
    location = module.rgshare.rgLocation
  }
}

module "key_vault_secret_acr" {
  source        = "./modules/kv-secret-acr-module-az"
  acr_username  = azurerm_container_registry.example.admin_username
  acr_password  = azurerm_container_registry.example.admin_password
  key_vault_id  = azurerm_key_vault.example.id
}
