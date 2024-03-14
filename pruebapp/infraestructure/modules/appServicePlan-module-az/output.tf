output "app_service_plan_id" {
  value = azurerm_service_plan.app_service_plan_OXH.id
}

output "app_service_plan_name" {
  value = azurerm_service_plan.app_service_plan_OXH.name
}

output "app_service_plan_location" {
  value = azurerm_service_plan.app_service_plan_OXH.location
}

output "app_service_plan_sku" {
  value = azurerm_service_plan.app_service_plan_OXH.sku_name
}