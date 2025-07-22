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
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.userpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agentpool_node_count"></a> [agentpool\_node\_count](#input\_agentpool\_node\_count) | Number of Vm's in the system nodepool. | `number` | n/a | yes |
| <a name="input_agentpool_vm_size"></a> [agentpool\_vm\_size](#input\_agentpool\_vm\_size) | Instance type to be used for system nodepool nodes. | `string` | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | Prefix to be attached to DNS hostnames associated with Kubernetes resources. | `string` | n/a | yes |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | The IP address within the Kubernetes service CIDR that will be assigned to the DNS service. This IP must be unique and not overlap with other services. | `string` | n/a | yes |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | The CIDR notation IP range assigned to the Docker bridge network used by AKS nodes. It must not overlap with any other IP ranges in your network. | `string` | n/a | yes |
| <a name="input_enable_private_cluster"></a> [enable\_private\_cluster](#input\_enable\_private\_cluster) | True or False. Makes cluster accessible/inaccessible from the internet. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Env currently being deployed, for use in generating resource name. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The version of Kubernetes the cluster will utilize. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location that the resources will be deployed in. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group that resources will be deployed in. | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The IP address range for the Kubernetes service network. This range is used by Kubernetes services and must not overlap with other address ranges in your network. | `string` | n/a | yes |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | Default SKU tier is set to Free used for Dev, QA and STG. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with the resource. | `map(string)` | n/a | yes |
| <a name="input_userpool_node_count"></a> [userpool\_node\_count](#input\_userpool\_node\_count) | The number of nodes that will be created for the userpool. | `number` | n/a | yes |
| <a name="input_userpool_vm_size"></a> [userpool\_vm\_size](#input\_userpool\_vm\_size) | The instance type that will be used by VMs in the userpool. | `string` | n/a | yes |
| <a name="input_vm_set_type"></a> [vm\_set\_type](#input\_vm\_set\_type) | The type of node pool to be created, either VirtualMachineScaleSets (Default) or AvailabilitySet (Legacy). | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | The Virtual network subnet ID where the node pools should be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Pre-made kubeconfig for use in accessing the cluster |
