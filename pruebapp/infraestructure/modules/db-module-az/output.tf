output "dbIDs" {
  value = azurerm_postgresql_flexible_server.DBOXHE.*.id
}

output "fdqns" {
  value = azurerm_postgresql_flexible_server.DBOXHE.*.fqdn
}