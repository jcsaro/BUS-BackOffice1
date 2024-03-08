resource "azurerm_key_vault_secret" "secrets_acr" {
  key_vault_id = var.key_vault_id
  name         = var.secret_name
  value        = var.secret_value
}
