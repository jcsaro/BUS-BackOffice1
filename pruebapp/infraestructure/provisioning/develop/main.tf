
#module "rgshare" {
#  source          = "../../modules/rg-module-az"
#  location        = var.location
#  short_company   = var.short_company
#  short_cloud     = var.short_cloud
#  short_env       = var.short_env
#  short_project   = var.short_project
#  resource_number = "01"
#}

module "acrShared" {
  source          = "../../modules/acr-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  resource_number = "01"
  rg_reference = {
    name     = var.rg_name
    location = var.location
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
    name     = var.rg_name
    location = var.location
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
    name     = var.rg_name
    location = var.location
  }
}

module "secret_acr" {
  source       = "../../modules/kv-secret-module-az"
  secret_name  = "acr${var.short_project}${var.short_env}"
  key_vault_id = module.keyvault.key_vault_id

  secret_value = jsonencode({
    username = "Username" #module.acrShared.admin_user
    password = "password" #module.acrShared.admin_pass
  })
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "password2" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
module "secret_db" {
  source       = "../../modules/kv-secret-module-az"
  secret_name  = "db01${var.short_project}${var.short_env}"
  key_vault_id = module.keyvault.key_vault_id

  secret_value = jsonencode({
    username = "psqladmin"                     #module.DB_OXHE.administrator_login
    password = random_password.password.result #module.DB_OXHE.administrator_login_password
  })
}

module "secret_db2" {
  source       = "../../modules/kv-secret-module-az"
  secret_name  = "db02${var.short_project}${var.short_env}"
  key_vault_id = module.keyvault.key_vault_id

  secret_value = jsonencode({
    username = "psqladmin"                      #module.DB_OXHE.administrator_login
    password = random_password.password2.result #module.DB_OXHE.administrator_login_password
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
  sku_name        = "Pv1"
  rg_reference = {
    name     = var.rg_name
    location = var.location
  }
}

module "AppServices1" {
  source                         = "../../modules/appService-module-az"
  webapp_name                    = "app service name"
  name_microservices_api         = "prueba ms"
  always_on                      = "true"
  image_name                     = "pruebadockerimage"
  container_registry_pwd         = module.key_vault_secret_acr.secretID
  key_vault_id                   = module.keyvault.key_vault_id
  container_registry_user        = module.acrShared.admin_user
  container_registry_loginserver = module.acrShared.url
  principal_resource_location    = var.location
  environment                    = var.short_env
  resource_group_name            = var.rg_name
  tags_mandatory = {
    "SupportBy" = "DevOps-Julio"
  }
  tenant_id                           = data.azurerm_client_config.current.tenant_id
  appinsights_connection_string       = "app insigs Key"
  principal_resource_location_acronym = var.short_cloud

}

module "vnetOXHE" {
  source          = "../../modules/vnet-module-az"
  resource_number = "01"
  rg_reference = {
    name     = var.rg_name
    location = var.location
  }
  address_space                      = ["172.26.250.32/27", "172.26.250.96/27", "172.26.253.160/28"]
  private_subnet_names_types         = ["AP", "WS", "DB"]
  private_subnet_prefixes            = ["172.26.250.32/27", "172.26.250.96/27", "172.26.253.160/28"]
  public_ip_name                     = ["ipnat01", "ipnat02", "ipnat03"]
  bastion_private_subnet_names_types = ["S1", "S2", "S3"]
}

module "DB_OXHE" {
  source          = "../../modules/db-module-az"
  location        = var.location
  short_company   = var.short_company
  short_cloud     = var.short_cloud
  short_env       = var.short_env
  short_project   = var.short_project
  delegated_subnet_id = module
  server_numberid = ["01", "02"]
  admin_username  = ["psqlad1", "psqlad2"]
  admin_password  = [random_password.password.result, random_password.password2.result]
  rg_reference = {
    name     = var.rg_name
    location = var.location
  }
}