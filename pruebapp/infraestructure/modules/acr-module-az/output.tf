output "idACR" {
  value = azurerm_container_registry.acr.id
}

output "url" {
  value = azurerm_container_registry.acr.login_server
}

output "admin_user" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "admin_pass" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}