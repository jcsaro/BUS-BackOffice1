resource "azurerm_virtual_network" "vnetOXHE" {
  name                = "${var.short_company}${var.short_cloud}VNET${var.short_project}${var.short_env}WS${var.resource_number}"
  address_space       = var.private_subnet_prefixes
  resource_group_name = var.rg_reference.name
  location            = var.rg_reference.location
}

resource "azurerm_subnet" "private" {
  count = length(private_subnet_names_types)
  name                 = "${var.short_company}${var.short_cloud}NET${var.short_project}${var.short_env}${var.private_subnet_names_types[count.index]}${var.resource_number}"
  resource_group_name  = var.rg_reference.name
  virtual_network_name = azurerm_virtual_network.vnetOXHE.name
  address_prefixes     = [var.private_subnet_prefixes[count.index]]
}