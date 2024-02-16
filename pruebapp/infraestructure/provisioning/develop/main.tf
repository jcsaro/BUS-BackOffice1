module "rgshare" {
    source ="../../modules/rg-module-az"
    Environment = var.Environment
    location = var.location
    product = var.ApplicationName
    short_location = var.short_location
         }