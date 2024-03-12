locals {

  lags = {
    "VPC_DEVVIE_1" = {
      leaf_1    = "101"
      leaf_2    = "102"
      from_port = 1
      to_port   = 1
      aep       = "aaep_devvie"
    }
    "VPC_DEVVIE_2" = {
      leaf_1    = "101"
      leaf_2    = "102"
      from_port = 2
      to_port   = 2
      aep       = "aaep_devvie"
    }
  }

}

resource "aci_vlan_pool" "devvie_vlan_pool" {
  name       = "devvie_vlan_pool"
  alloc_mode = "static"
}

resource "aci_ranges" "vlan_2_50_range" {
  vlan_pool_dn = aci_vlan_pool.devvie_vlan_pool.id
  from         = "vlan-2"
  to           = "vlan-50"
  alloc_mode   = "static"
}

resource "aci_physical_domain" "devvie_physdom" {
  name                      = "physdom_devvie"
  relation_infra_rs_vlan_ns = aci_vlan_pool.devvie_vlan_pool.id
}

resource "aci_attachable_access_entity_profile" "devvie_aaep" {
  name = "aaep_devvie"
  relation_infra_rs_dom_p = [
    aci_physical_domain.devvie_physdom.id
  ]
}

### Access generic resource for AEP, not for Network!!!!

resource "aci_access_generic" "epg_to_aep" {
  attachable_access_entity_profile_dn = aci_attachable_access_entity_profile.devvie_aaep.id
  name                                = "default"
}

### Interface Policies

resource "aci_lacp_policy" "lacp_policy" {
  ctrl = [
    "fast-sel-hot-stdby",
    "graceful-conv",
    "susp-individual",
  ]
  max_links = "16"
  min_links = "1"
  mode      = "active"
  name      = "lacp_policy_active"
}

resource "aci_cdp_interface_policy" "cdp_policy" {
  name     = "cdp_policy"
  admin_st = "enabled"
}

resource "aci_miscabling_protocol_interface_policy" "mcp_policy" {
  name     = "mcp_policy"
  admin_st = "enabled"
}

resource "aci_lldp_interface_policy" "lldp_policy" {
  name        = "lldp_policy"
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
}

resource "aci_fabric_if_pol" "if_policy" {
  name          = "link_level_auto"
  auto_neg      = "on"
  fec_mode      = "inherit"
  link_debounce = "100"
  speed         = "inherit"
}

###

resource "aci_leaf_access_bundle_policy_group" "devvie" {
  for_each                      = local.lags
  lag_t                         = "node"
  name                          = each.key
  relation_infra_rs_att_ent_p   = "uni/infra/attentp-${each.value.aep}"
  relation_infra_rs_h_if_pol    = aci_fabric_if_pol.if_policy.id
  relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp_policy.id
  relation_infra_rs_mcp_if_pol  = aci_miscabling_protocol_interface_policy.mcp_policy.id
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy.id
  relation_infra_rs_lacp_pol    = aci_lacp_policy.lacp_policy.id
  depends_on                    = [aci_attachable_access_entity_profile.devvie_aaep]
}
