# Terraform Setup for Local Environment

## Introduction
This project demonstrates how to set up Terraform in a local development environment to manage Azure resources. By following the steps in this guide, you will learn how to configure Terraform to authenticate with Azure using environment variables and deploy resources to your Azure subscription.

## Getting Started

To get started, you’ll need to install Terraform and configure your Azure credentials.

### 1. Installation Process

Follow these steps to install Terraform on your local system:

#### Windows
1. **Download Terraform**: 
   - Visit the official Terraform website to download the latest version: [Terraform Downloads](https://www.terraform.io/downloads.html)
   - Select the appropriate version for your system (Windows 64-bit, for example).
   
2. **Install Terraform**:
   - Extract the downloaded zip file to a directory of your choice (e.g., `C:\terraform`).
   - Add the `C:\terraform` directory to your system’s PATH environment variable:
     1. Right-click on "This PC" or "Computer" and choose "Properties".
     2. Click "Advanced system settings" and go to the "System Properties" window.
     3. Click on "Environment Variables".
     4. Under "System Variables", find the "Path" variable and click "Edit".
     5. Click "New" and add the path to the directory where you extracted Terraform (`C:\terraform`).
   
3. **Verify Installation**:
   - Open a command prompt and type `terraform --version` to check if Terraform is installed correctly. You should see the version of Terraform displayed.

### 2. Software Dependencies

- **Terraform**: Version 1.0 or higher.
- **Azure CLI**: The Azure CLI is optional but recommended for managing Azure resources. You can install it by following the instructions here: [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

### 3. Latest Releases

For the latest Terraform release, always refer to the official [Terraform Releases Page](https://github.com/hashicorp/terraform/releases).

### 4. API References

- **Terraform Provider for Azure**: [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- **Azure CLI Authentication**: [Azure CLI Auth](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure)

## Build and Test

### 1. Setup Azure Credentials

To authenticate Terraform with your Azure subscription, you need to configure several environment variables: **Subscription ID**, **Tenant ID**, **Client ID**, and **Client Secret**.

#### 1.1. Create an Azure Service Principal

1. Open a Command Prompt or PowerShell and log in to Azure CLI using `az login`:

2. Once logged in, create a Service Principal to use for Terraform authentication:
    `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your-subscription-id>"`
    This will generate an output with the following information:
    -  AppId (Client ID): The unique identifier for the application.
    - Password (Client Secret): The password used to authenticate the service principal.
    - TenantId: The unique identifier for the Azure Active Directory tenant.
    - SubscriptionId: Your Azure subscription ID.

3. Set Environment Variables
    Next, you need to configure your environment variables to securely store these credentials.
    Windows:
    - Open Command Prompt or PowerShell as Administrator.
    - Set the following environment variables (replace the placeholders with your actual values):
        `setx AZURE_SUBSCRIPTION_ID "<your-subscription-id>"`
        `setx AZURE_TENANT_ID "<your-tenant-id>"`
        `setx AZURE_CLIENT_ID "<your-client-id>"`
        `setx AZURE_CLIENT_SECRET "<your-client-secret>"`
        `setx AZURE_ACCESS_KEY "<your access key>"`
    - Restart your terminal or IDE to ensure the environment variables are loaded.
    Linux:
    - Open Command Prompt or PowerShell as Administrator.
        `export ARM_CLIENT_ID= <value>`
        `export ARM_CLIENT_SECRET <value>`
        `export ARM_TENANT_ID= <value>`
        `export ARM_SUBSCRIPTION_ID= <value>`
        `export ARM_ACCESS_KEY= <value>`
    - Set the following environment variables (replace the placeholders with your actual values):


4.  HOW TO EXECUTE
    - Executing Terraform PLAN
        `$ make tf-plan env=internal`
    - Executing Terraform APPLY
        `$ make tf-apply env=dev`
    - Executing Terraform DESTROY
        `$ make tf-destroy env=dev`

5. Please go through `Makefile` in this repo to understand the terrafrom lifecycle. 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | ./modules/acr | n/a |
| <a name="module_acr_private_endpoint"></a> [acr\_private\_endpoint](#module\_acr\_private\_endpoint) | ./modules/private_endpoint | n/a |
| <a name="module_aks"></a> [aks](#module\_aks) | ./modules/aks | n/a |
| <a name="module_app_config"></a> [app\_config](#module\_app\_config) | ./modules/app_config | n/a |
| <a name="module_app_gateway"></a> [app\_gateway](#module\_app\_gateway) | ./modules/app_gateway | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/keyvault | n/a |
| <a name="module_network_peering"></a> [network\_peering](#module\_network\_peering) | ./modules/network_peering | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | ./modules/resource_group | n/a |
| <a name="module_sa_private_endpoint_blob"></a> [sa\_private\_endpoint\_blob](#module\_sa\_private\_endpoint\_blob) | ./modules/private_endpoint | n/a |
| <a name="module_sa_private_endpoint_fileshare"></a> [sa\_private\_endpoint\_fileshare](#module\_sa\_private\_endpoint\_fileshare) | ./modules/private_endpoint | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account | n/a |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | ./modules/virtual_network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_admin_enabled"></a> [acr\_admin\_enabled](#input\_acr\_admin\_enabled) | Enable admin access to the ACR | `bool` | `false` | no |
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Name for ACR repository. Alphanumeric characters only. 5-50 characters. | `string` | n/a | yes |
| <a name="input_acr_public_network_access_enabled"></a> [acr\_public\_network\_access\_enabled](#input\_acr\_public\_network\_access\_enabled) | Allow public access to the ACR | `bool` | `false` | no |
| <a name="input_agw_backend_pools"></a> [agw\_backend\_pools](#input\_agw\_backend\_pools) | Backend pools | <pre>list(object({<br/>    name         = string<br/>    ip_addresses = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_agw_capacity"></a> [agw\_capacity](#input\_agw\_capacity) | Instance capacity for App Gateway | `number` | n/a | yes |
| <a name="input_agw_frontend_ports"></a> [agw\_frontend\_ports](#input\_agw\_frontend\_ports) | Frontend port objects | <pre>list(object({<br/>    name = string<br/>    port = number<br/>  }))</pre> | n/a | yes |
| <a name="input_agw_frontend_private_ip"></a> [agw\_frontend\_private\_ip](#input\_agw\_frontend\_private\_ip) | The IP address that will be assigned to the private frontend of the App Gateway | `string` | n/a | yes |
| <a name="input_agw_http_settings"></a> [agw\_http\_settings](#input\_agw\_http\_settings) | Backend HTTP settings | <pre>list(object({<br/>    name            = string<br/>    port            = number<br/>    protocol        = string<br/>    request_timeout = number<br/>  }))</pre> | n/a | yes |
| <a name="input_agw_listeners"></a> [agw\_listeners](#input\_agw\_listeners) | HTTP listeners | <pre>list(object({<br/>    name                           = string<br/>    frontend_ip_configuration_name = string<br/>    frontend_port_name             = string<br/>    protocol                       = string<br/>    host_name                      = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_agw_routing_rules"></a> [agw\_routing\_rules](#input\_agw\_routing\_rules) | Routing rules | <pre>list(object({<br/>    name                       = string<br/>    http_listener_name         = string<br/>    backend_address_pool_name  = string<br/>    backend_http_settings_name = string<br/>    priority                   = number<br/>  }))</pre> | n/a | yes |
| <a name="input_aks_agentpool_node_count"></a> [aks\_agentpool\_node\_count](#input\_aks\_agentpool\_node\_count) | Number of Vm's in a pool | `number` | n/a | yes |
| <a name="input_aks_agentpool_vm_size"></a> [aks\_agentpool\_vm\_size](#input\_aks\_agentpool\_vm\_size) | VM size for a node pool | `string` | n/a | yes |
| <a name="input_aks_dns_prefix"></a> [aks\_dns\_prefix](#input\_aks\_dns\_prefix) | The name that will be assigned to the cluster | `string` | `""` | no |
| <a name="input_aks_dns_service_ip"></a> [aks\_dns\_service\_ip](#input\_aks\_dns\_service\_ip) | The IP address that will be assigned to AKS DNS Service | `string` | `""` | no |
| <a name="input_aks_docker_bridge_cidr"></a> [aks\_docker\_bridge\_cidr](#input\_aks\_docker\_bridge\_cidr) | The IP range for Docker bridge network used by AKS nodes; must not overlap with other CIDRs in the entire virtual network | `string` | `""` | no |
| <a name="input_aks_enable_private_cluster"></a> [aks\_enable\_private\_cluster](#input\_aks\_enable\_private\_cluster) | Set to TRUE to configure AKS Cluster as Private | `string` | `""` | no |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | The version of Kubernetes that will be used in the AKS Cluster | `string` | `""` | no |
| <a name="input_aks_service_cidr"></a> [aks\_service\_cidr](#input\_aks\_service\_cidr) | The CIDR that will be used for internal Kubernetes Service IPs (ClusterIP); must not overlap with other network ranges | `string` | `""` | no |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | The SKU tier for the K8S cluster. Values: Free or Paid (Comes with Uptime SLAs from Azure) | `string` | `"Free"` | no |
| <a name="input_aks_userpool_node_count"></a> [aks\_userpool\_node\_count](#input\_aks\_userpool\_node\_count) | Number of Vm's in a pool | `number` | n/a | yes |
| <a name="input_aks_userpool_vm_size"></a> [aks\_userpool\_vm\_size](#input\_aks\_userpool\_vm\_size) | VM size for a node pool | `string` | n/a | yes |
| <a name="input_aks_vm_set_type"></a> [aks\_vm\_set\_type](#input\_aks\_vm\_set\_type) | The type of node pool to be created, either VirtualMachineScaleSets (Default) or AvailabilitySet (Legacy). | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | Deployment environment name (internal, prod, staging) | `string` | n/a | yes |
| <a name="input_kv_full_access_object_ids"></a> [kv\_full\_access\_object\_ids](#input\_kv\_full\_access\_object\_ids) | The object IDs of any additional users/service principals that will be given full access through the access policy. | `list(string)` | n/a | yes |
| <a name="input_kv_pipeline_access_object_id"></a> [kv\_pipeline\_access\_object\_id](#input\_kv\_pipeline\_access\_object\_id) | The object ID of the user/service principal running the pipeline that will be given access through the access policy. | `string` | `"00000000-0000-0000-0000-000000000000"` | no |
| <a name="input_kv_readonly_access_object_ids"></a> [kv\_readonly\_access\_object\_ids](#input\_kv\_readonly\_access\_object\_ids) | The object IDs of any additional users/service principals that will be given full access through the access policy. | `list(string)` | n/a | yes |
| <a name="input_kv_tenant_id"></a> [kv\_tenant\_id](#input\_kv\_tenant\_id) | Azure AD tenant ID. Inject via pipeline or tfvars. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where Terraform should deploy all resources | `string` | `""` | no |
| <a name="input_np_vhub_name"></a> [np\_vhub\_name](#input\_np\_vhub\_name) | The name of the Existing Virtual Hub within the Existing Virtual WAN | `string` | `""` | no |
| <a name="input_np_vwan_name"></a> [np\_vwan\_name](#input\_np\_vwan\_name) | The name of the Existing Virtual WAN being peered to | `string` | `""` | no |
| <a name="input_np_vwan_subscription_id"></a> [np\_vwan\_subscription\_id](#input\_np\_vwan\_subscription\_id) | The subscription ID of the Existing VWAN for Peering configuration. Used in Second Provider Block | `string` | `""` | no |
| <a name="input_np_vwan_vhub_rg_name"></a> [np\_vwan\_vhub\_rg\_name](#input\_np\_vwan\_vhub\_rg\_name) | The name of the Resource Group where the existing VWAN and VHUB live | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name that will be assigned to the Resource Group | `string` | `""` | no |
| <a name="input_sa_account_kind"></a> [sa\_account\_kind](#input\_sa\_account\_kind) | The kind of storage account (StorageV2, BlobStorage, etc). | `string` | `"StorageV2"` | no |
| <a name="input_sa_account_replication_type"></a> [sa\_account\_replication\_type](#input\_sa\_account\_replication\_type) | Replication type | `string` | `"LRS"` | no |
| <a name="input_sa_account_tier"></a> [sa\_account\_tier](#input\_sa\_account\_tier) | Standard or Premium | `string` | `"Standard"` | no |
| <a name="input_sa_allow_nested_items_to_be_public"></a> [sa\_allow\_nested\_items\_to\_be\_public](#input\_sa\_allow\_nested\_items\_to\_be\_public) | Whether public access to nested items is allowed. | `bool` | `false` | no |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | The Storage account name (must be globally unique and 3-24 lowercase letters/numbers). | `string` | n/a | yes |
| <a name="input_sa_public_network_access_enabled"></a> [sa\_public\_network\_access\_enabled](#input\_sa\_public\_network\_access\_enabled) | Allow or deny public network access (Enabled or Disabled). | `string` | `"Disabled"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags that will be associated with all Terraform created resources | `map(string)` | <pre>{<br/>  "environment": ""<br/>}</pre> | no |
| <a name="input_tf_subscription_id"></a> [tf\_subscription\_id](#input\_tf\_subscription\_id) | The subscription ID where Terraform will deploy all resources. Used in main Provider block | `string` | `""` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space that will be assigned for the Virutal Network | `string` | `""` | no |
| <a name="input_vnet_agw_subnet_cidr"></a> [vnet\_agw\_subnet\_cidr](#input\_vnet\_agw\_subnet\_cidr) | CIDR for use by AGW exclusive subnet | `string` | n/a | yes |
| <a name="input_vnet_aks_nodes_subnet_cidr"></a> [vnet\_aks\_nodes\_subnet\_cidr](#input\_vnet\_aks\_nodes\_subnet\_cidr) | CIDR for use by AGW exclusive subnet | `string` | n/a | yes |
| <a name="input_vnet_private_subnet_prefix"></a> [vnet\_private\_subnet\_prefix](#input\_vnet\_private\_subnet\_prefix) | CIDR block for the private subnet | `string` | n/a | yes |
| <a name="input_vnet_public_subnet_prefix"></a> [vnet\_public\_subnet\_prefix](#input\_vnet\_public\_subnet\_prefix) | CIDR block for the public subnet | `string` | n/a | yes |

## Outputs

No outputs.
