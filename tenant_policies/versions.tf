terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.11.1"
    }
    fmc = {
      source  = "CiscoDevNet/fmc"
      version = "0.2.3"
    }
    netbox = {
      source = "e-breuninger/netbox"
      version = "3.7.3"
    }
  }
}
