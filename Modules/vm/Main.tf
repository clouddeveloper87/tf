#Import Resource Group
data "azurerm_resource_group" "RG" {
  name = "HassanRG"
}

resource "azurerm_virtual_machine" "vm" {
  count                = length(var.vm_names)
  name                 = var.vm_names[count.index]
  location             = var.location
  resource_group_name  = var.resource_group_name
  network_interface_ids = [element(var.network_interface_ids, count.index)]
  vm_size              = var.vm_size

  storage_os_disk {
    name              = "${var.vm_names[count.index]}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_names[count.index]
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "Terraform"
  }
}

