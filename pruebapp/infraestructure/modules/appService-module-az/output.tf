output "app_service_id" {
  value = azurerm_linux_web_app.webapp-linux.id
}

output "default_site_hostname" {
  value = azurerm_linux_web_app.webapp-linux.default_hostname
}

output "default_site_hostname_secondary" {
  value = length(azurerm_linux_web_app.webapp-linux-secondary) > 0 ? azurerm_linux_web_app.webapp-linux-secondary[0].default_hostname : null
}