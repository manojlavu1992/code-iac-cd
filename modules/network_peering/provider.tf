## Needed to get rid of warning when using both providers for data objects
## Removal doesnt break anything. 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
      configuration_aliases = [azurerm.vwan]
    }
  }
}