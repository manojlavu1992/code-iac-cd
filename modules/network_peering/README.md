## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |
| <a name="provider_azurerm.vwan"></a> [azurerm.vwan](#provider\_azurerm.vwan) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_hub_connection.vnet_to_vwan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection) | resource |
| [azurerm_virtual_hub.shared_vhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_hub) | data source |
| [azurerm_virtual_wan.shared_vwan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_wan) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_remote_virtual_network_id"></a> [remote\_virtual\_network\_id](#input\_remote\_virtual\_network\_id) | The ID of the virtual network to peer. | `string` | n/a | yes |
| <a name="input_vhub_name"></a> [vhub\_name](#input\_vhub\_name) | The name of the Virtual Hub to peer with. | `string` | n/a | yes |
| <a name="input_vhub_rg_name"></a> [vhub\_rg\_name](#input\_vhub\_rg\_name) | The name of the resource group containing the Virtual Hub. | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the local virtual network to be peered. | `string` | n/a | yes |
| <a name="input_vwan_name"></a> [vwan\_name](#input\_vwan\_name) | The name of the Virtual WAN associated with the Virtual Hub. | `string` | n/a | yes |
| <a name="input_vwan_rg_name"></a> [vwan\_rg\_name](#input\_vwan\_rg\_name) | The name of the resource group containing the Virtual WAN. | `string` | n/a | yes |

## Outputs

No outputs.
