module "devvie_project_1" {
  source          = "./network"
  tenant_os       = module.tenant_policies.devvie_tenant
  vrf_os          = module.tenant_policies.devvie_vrf
  aep_access      = module.fabric_policies.aep_generic
  physical_domain = module.fabric_policies.physical_domain
  name            = "devvie_project_1"
  vlan_id         = 15
  mode            = "regular"
  gateway_address = "192.168.15.1/24"
  route_scope     = ["public", "shared"]
  provided_contract = module.tenant_policies.established_ct
}
module "devvie_project_2" {
  source          = "./network"
  tenant_os       = module.tenant_policies.devvie_tenant
  vrf_os          = module.tenant_policies.devvie_vrf
  aep_access      = module.fabric_policies.aep_generic
  physical_domain = module.fabric_policies.physical_domain
  name            = "devvie_project_2"
  vlan_id         = 16
  mode            = "regular"
  gateway_address = "192.168.16.1/24"
  route_scope     = ["public"]
  provided_contract = module.tenant_policies.established_ct
}

module "devvie_project_3" {
  source          = "./network"
  tenant_os       = module.tenant_policies.devvie_tenant
  vrf_os          = module.tenant_policies.devvie_vrf
  aep_access      = module.fabric_policies.aep_generic
  physical_domain = module.fabric_policies.physical_domain
  name            = "devvie_project_3"
  vlan_id         = 17
  mode            = "regular"
  gateway_address = "192.168.17.1/24"
  route_scope     = ["private"]
  provided_contract = module.tenant_policies.established_ct
}
