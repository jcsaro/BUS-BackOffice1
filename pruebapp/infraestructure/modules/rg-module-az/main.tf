resource "azurerm_resource_group" "rgShared" {
  name     = "${var.product}${var.Environment}${var.short_location}shared"
    location = var.location
    }