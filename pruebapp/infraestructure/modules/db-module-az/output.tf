output "dbIDs" {
  value = azurerm_postgresql_server.DB_OXHE.*.id
}

output "dbIDs" {
  value = azurerm_postgresql_server.DB_OXHE.*.fdqn
}