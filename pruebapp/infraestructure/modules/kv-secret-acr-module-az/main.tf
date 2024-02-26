data "terraform_remote_state" "acr_outputs" {
  backend = "local"  # Dudas si se almacena en terraform cloud como se invoca
  config = {
    path = "path/to/your/terraform-state-file"
  }
}

resource "azurerm_key_vault_secret" "acr_credentials" {
  name         = "AcrCredentials"
  value        = jsonencode({
    username  = data.terraform_remote_state.acr_outputs.outputs.acr_admin_username
    password  = data.terraform_remote_state.acr_outputs.outputs.acr_admin_password
  })