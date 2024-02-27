resource "azurerm_key_vault_secret" "secret" {
  key_vault_id = var.key_vault_id
  name         = "AcrCredentials"
  value        = var.secret_value
}