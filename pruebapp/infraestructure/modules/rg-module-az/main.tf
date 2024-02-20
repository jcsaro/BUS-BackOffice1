resource "azurerm_resource_group" "rgshared" {
  name     = "${var.rg_name}${var.product}${var.Environment}${var.short_location}shared"
    location = var.location
    }