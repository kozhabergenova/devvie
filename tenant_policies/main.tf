data "aci_tenant" "common" {
  name  = "common"
}

resource "aci_vrf" "common" {
  tenant_dn  = data.aci_tenant.common.id
  name       = "common"
}

resource "aci_tenant" "devvie" {
  name        = "devvie"
  description = "Tenant for Devvie"
}

resource "aci_vrf" "devvie" {
  tenant_dn              = aci_tenant.devvie.id
  name                   = "devvie"
  description            = "VRF for Devvie"
}

### The contract is already created on ACI

# data "aci_contract" "data_contract" {
#   tenant_dn  = data.aci_tenant.common.id
#   name       = "data_contract"
# }

###