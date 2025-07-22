resource_group_name = "IaC-ClearD-Production-Resource-Group"
location            = "Canada Central"
tags = {
  environment = "Production"
}

vnet_name          = "IaC-ClearD-Production-Virtual-Network"
vnet_address_space = "172.17.0.0/16"
private_subnets = [
  { name = "CD-Web-01", address_prefix = "172.17.10.0/24" },
  { name = "CD-Web-02", address_prefix = "172.17.20.0/24" },
  { name = "CD-Web-03", address_prefix = "172.17.30.0/24" }
]
public_subnets = [
  { name = "CD-P-Web-01", address_prefix = "172.17.100.0/24" },
  { name = "CD-P-Web-02", address_prefix = "172.17.110.0/24" }
]


# iac_tfstate = "iactfstate"
# container_name = "terraform-state"
# account_tier = "Standard"
# account_replication_type = "LRS"
