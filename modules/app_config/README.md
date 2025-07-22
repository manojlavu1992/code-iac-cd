## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.appconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The deployment environment (e.g., internal, staging, prod). Used to generate environment-specific resource names. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the App Configuration resource will be deployed. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Azure Resource Group in which the App Configuration will be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier (SKU) for the App Configuration resource. Valid values include 'free' and 'standard'. | `string` | `"standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the App Configuration resource for organization and cost management. | `map(string)` | `{}` | no |

## Outputs

No outputs.
