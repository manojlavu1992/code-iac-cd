# output "vm_public_ip_address" {
#   value = azurerm_public_ip.iac_public_ip.ip_address
# }

output "vm_id" {
  value = azurerm_linux_virtual_machine.iac_vm.id
}
