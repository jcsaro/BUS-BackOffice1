resource "azurerm_key_vault_secret" "secrets_acr" {
  key_vault_id = var.key_vault_id
  name         = "AcrCredentials"
  value        = var.secret_value
}

resource "azurerm_key_vault_secret" "secrets_db" {
  key_vault_id = var.key_vault_id
  name         = "DBCredentials"
  value        = var.secret_value
}