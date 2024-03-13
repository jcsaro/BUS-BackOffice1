output "private_subnet_ids" {
  value = azurerm_subnet.private.*.id
}
output "vnet_id" {
  value = azurerm_subnet.private.*.id
}
output "bastion_id" {
  value = azurerm_subnet.private.*.id
}