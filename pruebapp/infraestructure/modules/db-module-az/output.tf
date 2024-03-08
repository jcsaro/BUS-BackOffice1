output "dbIDs" {
  value = azurerm_postgresql_server.DB_OXHE.*.id
}

output "fdqns" {
  value = azurerm_postgresql_server.DB_OXHE.*.fdqn
}