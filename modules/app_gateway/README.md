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
| [azurerm_application_gateway.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_public_ip.agw_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_pools"></a> [backend\_pools](#input\_backend\_pools) | A list of backend address pools. Each pool includes a name and the list of IP addresses of backend targets. | <pre>list(object({<br/>    name         = string<br/>    ip_addresses = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The instance capacity to be allocated to the Application Gateway. This defines the number of instances. | `number` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The deployment environment (e.g., internal, staging, prod). Used for naming resources. | `string` | n/a | yes |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | A list of frontend ports for the Application Gateway to listen on. Each object defines a name and port number. | <pre>list(object({<br/>    name = string<br/>    port = number<br/>  }))</pre> | n/a | yes |
| <a name="input_frontend_private_ip"></a> [frontend\_private\_ip](#input\_frontend\_private\_ip) | Static private IP address assigned to the private frontend configuration of the Application Gateway. | `string` | n/a | yes |
| <a name="input_http_settings"></a> [http\_settings](#input\_http\_settings) | A list of backend HTTP settings including port, protocol, and timeout values for each backend pool. | <pre>list(object({<br/>    name            = string<br/>    port            = number<br/>    protocol        = string<br/>    request_timeout = number<br/>  }))</pre> | n/a | yes |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | A list of HTTP listeners that define how the Application Gateway listens for incoming requests. Includes frontend IP config and port. | <pre>list(object({<br/>    name                           = string<br/>    frontend_ip_configuration_name = string<br/>    frontend_port_name             = string<br/>    protocol                       = string<br/>    host_name                      = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Application Gateway will be deployed. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Azure Resource Group in which the Application Gateway will be deployed. | `string` | n/a | yes |
| <a name="input_routing_rules"></a> [routing\_rules](#input\_routing\_rules) | A list of request routing rules that define how requests are directed from listeners to backend pools. | <pre>list(object({<br/>    name                       = string<br/>    http_listener_name         = string<br/>    backend_address_pool_name  = string<br/>    backend_http_settings_name = string<br/>    priority                   = number<br/>  }))</pre> | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet within which the Application Gateway will be deployed. This should be a dedicated subnet. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the Application Gateway for resource organization and cost tracking. | `map(string)` | n/a | yes |

## Outputs

No outputs.
