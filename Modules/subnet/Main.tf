#Import Resource Group
data "azurerm_resource_group" "RG" {
  name = "HassanRG"
}

resource "azurerm_subnet" "subnet" {
  # count                = var.subnet_name
  name                 = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes       = var.address_prefixes
}


resource "azurerm_network_interface" "main" {
  name                = var.nicname
  location            = var.location
  resource_group_name = data.azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "testconfiguration1"
    # subnet_id                      = module.example_subnets.subnet_ids[count.index]
    # subnet_id                     = azurerm_subnet.internal.id
    subnet_id                        = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
