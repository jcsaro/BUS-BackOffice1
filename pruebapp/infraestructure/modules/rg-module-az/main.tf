resource "azurerm_resource_group" "rgshared" {
  name     = "${var.short_company}${var.short_cloud}RG${var.short_company}HD${var.resource_number}"
  location = var.location
}