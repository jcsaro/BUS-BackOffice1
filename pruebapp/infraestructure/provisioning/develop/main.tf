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
  source        = "../../modules/kv-secret-module-az"
  secret_name = "acr${var.short_project}${var.short_env}"
  key_vault_id = module.keyvault.key_vault_id
  secret_value = jsonencode({
    username  = module.acrShared.admin_user
    password  = module.acrShared.admin_pass
  })
}


module "AppServicesPlan" {
  source          = "../../modules/appServicePlan-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  resource_number = "01"
  sku_tier        = "Standard"
  sku_size        = "S1"
  rg_reference    = {
    name          = module.rgshare.rgName
    location      = module.rgshare.rgLocation
  }
}