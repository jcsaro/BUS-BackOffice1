output "secretID" {
  value = azurerm_key_vault_secret.secret.id
}

output "secretResourceID" {
  value = azurerm_key_vault_secret.secret.resource_id
}