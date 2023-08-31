resource "azurerm_resource_group" "frogman" {
  name     = "frogman-rg"
  location = "East US"
}

resource "azurerm_network_security_group" "frogman" {
  name                = "frogman-security-group"
  location            = "East US"
  resource_group_name = "frogman-rg"
}

resource "azurerm_virtual_network" "frogman" {
  name                = "frogman-network"
  location            = "East US"
  resource_group_name = "frogman-rg"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = "frogman-security-group"
  }

  tags = {
    environment = "Production"
  }
}