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
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.full_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.pipeline_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.readonly_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Deployment environment name (internal, prod, staging). Used for naming resources. | `string` | n/a | yes |
| <a name="input_full_access_object_ids"></a> [full\_access\_object\_ids](#input\_full\_access\_object\_ids) | List of object IDs (users or service principals) that will be granted full access to the Key Vault. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Key Vault should be deployed. | `string` | n/a | yes |
| <a name="input_pipeline_access_object_id"></a> [pipeline\_access\_object\_id](#input\_pipeline\_access\_object\_id) | Object ID of the pipeline identity (user or service principal) that will be granted limited access for CI/CD purposes. | `string` | n/a | yes |
| <a name="input_readonly_access_object_ids"></a> [readonly\_access\_object\_ids](#input\_readonly\_access\_object\_ids) | List of object IDs (users or service principals) that will be granted read-only access to the Key Vault. | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Key Vault will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to associate with the Key Vault and related resources. | `map(string)` | <pre>{<br/>  "environment": ""<br/>}</pre> | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID for the Key Vault. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keyvault_id"></a> [keyvault\_id](#output\_keyvault\_id) | n/a |
| <a name="output_keyvault_uri"></a> [keyvault\_uri](#output\_keyvault\_uri) | n/a |
