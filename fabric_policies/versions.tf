terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.11.1"
    }
    fmc = {
      source  = "CiscoDevNet/fmc"
      version = "1.4.8"
    }
    netbox = {
      source = "e-breuninger/netbox"
      version = "3.8.0"
    }
  }
}
