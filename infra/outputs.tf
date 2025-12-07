output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "webapp_url" {
  value = azurerm_linux_web_app.web.default_hostname
}
output "traffic_manager_dns" {
  value = azurerm_traffic_manager_profile.tm.fqdn
}
output "fallback_site" {
  value = azurerm_storage_account.fallback.primary_web_endpoint
}
output "primary_target" {
  value = azurerm_linux_web_app.web.default_hostname
}
