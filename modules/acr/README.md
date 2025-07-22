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
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Specifies the name of the Azure Container Registry (ACR). Must be 5-50 alphanumeric characters. | `string` | n/a | yes |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Determines whether the ACR admin user account is enabled. This provides access credentials for tools like Docker. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | The deployment environment (e.g., dev, staging, prod). Used to generate environment-specific resource names. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the ACR will be created. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Indicates whether the ACR is accessible over the public internet. Set to false to restrict access to private endpoints only. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Azure Resource Group in which the ACR will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the ACR resource for tracking and management purposes. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | n/a |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | n/a |
