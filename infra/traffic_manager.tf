resource "azurerm_traffic_manager_profile" "tm" {
  name                = "${var.prefix}-tm"
  resource_group_name = azurerm_resource_group.rg.name

  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "${var.prefix}-tm"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTPS"
    port     = 443
    path     = "/health"
  }

  tags = {
    environment = "student"
  }
}

# Primary endpoint: your App Service
resource "azurerm_traffic_manager_external_endpoint" "primary" {
  name              = "primary-endpoint"
  profile_id        = azurerm_traffic_manager_profile.tm.id
  target            = azurerm_linux_web_app.web.default_hostname
  endpoint_location = azurerm_resource_group.rg.location
  priority          = 1
}

# Storage account for cheap fallback
resource "azurerm_storage_account" "fallback" {
  name                     = "${lower(var.prefix)}fb${random_string.rand2.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }
}

# Fallback endpoint: storage website
resource "azurerm_traffic_manager_external_endpoint" "fallback" {
  name       = "fallback-endpoint"
  profile_id = azurerm_traffic_manager_profile.tm.id

  # FIXED: hostname only, no https:// and no trailing slash
  target = trimsuffix(
              replace(azurerm_storage_account.fallback.primary_web_endpoint, "https://", ""),
              "/"
           )

  endpoint_location = azurerm_resource_group.rg.location
  priority          = 2
}

resource "random_string" "rand2" {
  length  = 5
  special = false
  numeric = true
  upper   = false
  lower   = true
}
