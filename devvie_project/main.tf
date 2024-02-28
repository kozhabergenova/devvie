locals {

  subnet       = cidrsubnet(var.gateway_address, 0, 0)
  gateway_only = cidrhost(local.subnet, 1)

}

data "aci_tenant" "common" {
  name = "common"
}

resource "aci_application_profile" "devvie_app_profile" {
  tenant_dn   = var.tenant_os
  name        = "${var.name}_ap"
  description = "${var.name} ap"
}

resource "aci_bridge_domain" "devvie_bridge_domain" {
  tenant_dn                   = var.tenant_os
  description                 = "Bridge Domain for ${var.name}"
  name                        = "vlan_${var.vlan_id}_bd"
  relation_fv_rs_ctx          = var.vrf_os
  optimize_wan_bandwidth      = "no"
  annotation                  = "tag_bd"
  arp_flood                   = "yes"
  ep_clear                    = "no"
  host_based_routing          = "no"
  intersite_bum_traffic_allow = "yes"
  intersite_l2_stretch        = "yes"
  ip_learning                 = "yes"
  limit_ip_learn_to_subnets   = "yes"
  mcast_allow                 = "no"
  multi_dst_pkt_act           = "bd-flood"
  bridge_domain_type          = "regular"
  unk_mac_ucast_act           = "proxy"
  unk_mcast_act               = "flood"
  vmac                        = "not-applicable"
}

resource "aci_application_epg" "devvie_application_epg" {
  application_profile_dn = aci_application_profile.devvie_app_profile.id
  relation_fv_rs_bd      = aci_bridge_domain.devvie_bridge_domain.id
  name                   = "${var.name}_epg"
  description            = "EPG for ${var.name}"
  annotation             = "tag_epg"
  exception_tag          = "0"
  flood_on_encap         = "disabled"
  has_mcast_source       = "no"
  is_attr_based_epg      = "no"
  match_t                = "AtleastOne"
  pc_enf_pref            = "unenforced"
  pref_gr_memb           = "exclude"
  prio                   = "unspecified"
  shutdown               = "no"
}

# From the provider documentation: name - (Required) The name of the user defined function object. Name must be "default".

resource "aci_epgs_using_function" "epg_to_aep_assign" {
  access_generic_dn = "${var.aep_access}"
  tdn               = aci_application_epg.devvie_application_epg.id
  encap             = "vlan-${var.vlan_id}"
  mode              = var.mode
}

resource "aci_epg_to_domain" "net_2_domain" {
  application_epg_dn = aci_application_epg.devvie_application_epg.id
  tdn                = var.physical_domain
}

# resource "aci_epg_to_contract" "provided_contract" {
#   application_epg_dn = aci_application_epg.devvie_application_epg.id
#   contract_dn        = var.provided_contracts
#   contract_type      = "provider"
# }

resource "aci_subnet" "subnet" {
  parent_dn   = aci_application_epg.devvie_application_epg.id
  ip          = var.gateway_address
  preferred   = "no"
  scope       = var.route_scope
  description = "This subnet is created by terraform"
}

## Resource of the FMC's TF Provider, which will be used to define ACP policy later
resource "fmc_network_objects" "aci_net" {
  name  = var.name
  value = local.subnet
}

###NETBOX PART###

resource "netbox_vlan" "vlan" {
  name = var.name
  vid  = var.vlan_id
}

resource "netbox_prefix" "prefix" {
  prefix  = local.subnet
  status  = "active"
  vlan_id = netbox_vlan.vlan.id
}
