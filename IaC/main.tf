resource "azurerm_resource_group" "sla_rg" {
  name     = "${var.project_name}-rg-${var.location}-${var.env_id}"
  location = var.location
  tags = {
        environment = var.env_id
        source = var.src_key
    }
}

resource "azurerm_storage_account" "sla_storage_account" {
  # Build a storage account name that is compliant:
  # - Lowercase only.
  # - No hyphens.
  # - Using abbreviations to keep within the character limits.
  name                     = lower("${var.project_name}sa${replace(var.location, "-", "")}${var.env_id}")
  resource_group_name      = azurerm_resource_group.sla_rg.name
  location                 = azurerm_resource_group.sla_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
        environment = var.env_id
        source = var.src_key
    }
}

resource "azurerm_service_plan" "sla_service_plan" {
  name                = "${var.project_name}-sp-${var.location}-${var.env_id}"
  resource_group_name = azurerm_resource_group.sla_rg.name
  location            = azurerm_resource_group.sla_rg.location
  os_type             = "Windows"
  sku_name            = "Y1"
  tags = {
        environment = var.env_id
        source = var.src_key
    }
}

resource "azurerm_windows_function_app" "sla_function_app" {
  name                = "${var.project_name}-fun-${var.location}-${var.env_id}"
  resource_group_name = azurerm_resource_group.sla_rg.name
  location            = azurerm_resource_group.sla_rg.location

  storage_account_name       = azurerm_storage_account.sla_storage_account.name
  storage_account_access_key = azurerm_storage_account.sla_storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.sla_service_plan.id

  site_config {}
  tags = {
        environment = var.env_id
        source = var.src_key
    }
}