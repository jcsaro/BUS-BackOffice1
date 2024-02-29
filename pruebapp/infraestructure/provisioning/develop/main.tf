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
    username  = "Username"#module.acrShared.admin_user
    password  = "password"#module.acrShared.admin_pass
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
  sku_name = "Pv1"
  rg_reference    = {
    name          = module.rgshare.rgName
    location      = module.rgshare.rgLocation
  }
}

module "AppServices1" {
  source          = "../../modules/appService-module-az"
  webapp_name = "app service name"
  name_microservices_api = "prueba ms"
  always_on = "true"
  image_name = "pruebadockerimage"
  container_registry_pwd = module.key_vault_secret_acr.secretID
  key_vault_id = module.keyvault.key_vault_id
  container_registry_user = module.acrShared.admin_user
  container_registry_loginserver = module.acrShared.url
  principal_resource_location = var.location
  environment = var.short_env
  resource_group_name =  module.rgshare.rgName
  tags_mandatory = {
    "SupportBy"= "DevOps-Julio"
  }
  tenant_id = data.azurerm_client_config.current.tenant_id
  appinsights_connection_string= "app insigs Key"
  principal_resource_location_acronym = var.short_cloud

}

module "vnet" {
  source          = "../../modules/vnet-module-az"
  address_space       = ["10.0.0.0/16"] #pendiente las direcciones
  resource_number = "01"
  rg_reference = {
    name     = module.rgshare.rgName
    location = module.rgshare.rgLocation
  }
  public_subnet_name      = "public-subnet"
  public_subnet_prefixes  = ["10.0.1.0/24"]#pendiente las direcciones
  private_subnet_name     = "private-subnet"
  private_subnet_prefixes = ["10.0.2.0/24"]#pendiente las direcciones
}
