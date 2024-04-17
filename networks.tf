module "devvie_project_1" {
  source            = "./network"
  tenant            = module.tenant_policies.devvie_tenant
  vrf               = module.tenant_policies.devvie_vrf
  aep_access        = module.fabric_policies.aep_generic
  physical_domain   = module.fabric_policies.physical_domain
  name              = "devvie_project_1"
  vlan_id           = 15
  mode              = "regular"
  gateway_address   = "192.168.15.1/24"
  route_scope       = ["public", "shared"]
  provided_contract = module.tenant_policies.established_ct
}




