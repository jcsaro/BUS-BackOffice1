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
resource "azurerm_nat_gateway" "natOXHE" {
  name                    = "${var.short_company}${var.short_cloud}NAT${var.short_project}${var.short_env}WS${var.resource_number}"
  location                = var.rg_reference.location
  resource_group_name     = var.rg_reference.name
  public_ip_addresses     = [azurerm_public_ip.nat_public_ip.id]
  sku_name                = var.sku_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
}

resource "azurerm_public_ip" "nat_public_ip" {
  name                = var.public_ip_name
  location            = var.rg_reference.location
  resource_group_name = var.rg_reference.name
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "BastionOXHE" {
  count = length(bastion_private_subnet_names_types)
  name                = "${var.short_company}${var.short_cloud}BA${var.short_project}${var.short_env}${var.bastion_subnet[count.index]}${var.resource_number}"
  location            = var.rg_reference.location
  resource_group_name = var.rg_reference.name
  ip_configuration {
    name                 = "configuration"
    subnet_id            =  
    public_ip_address_id =
  }
}