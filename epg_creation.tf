# resource "aci_tenant" "devvie" {
#   name        = "devvie"
# }

# resource "aci_vrf" "devvie" {
#   tenant_dn              = aci_tenant.devvie.id
#   name                   = "devvie_vrf"
# }

# resource "aci_application_profile" "devvie" {
#   tenant_dn  = aci_tenant.devvie.id
#   name       = "devvie"
# }

# resource "aci_bridge_domain" "devvie" {
#   tenant_dn                   = aci_tenant.devvie.id
#   description                 = "from terraform"
#   name                        = "devvie_bd"
#   optimize_wan_bandwidth      = "no"
#   annotation                  = "tag_bd"
#   arp_flood                   = "no"
#   ep_clear                    = "no"
#   ep_move_detect_mode         = "garp"
#   host_based_routing          = "no"
#   intersite_bum_traffic_allow = "yes"
#   intersite_l2_stretch        = "yes"
#   ip_learning                 = "yes"
#   ipv6_mcast_allow            = "no"
#   limit_ip_learn_to_subnets   = "yes"
#   ll_addr                     = "::"
#   mac                         = "00:22:BD:F8:19:FF"
#   mcast_allow                 = "yes"
#   multi_dst_pkt_act           = "bd-flood"
#   name_alias                  = "alias_bd"
#   bridge_domain_type          = "regular"
#   unicast_route               = "no"
#   unk_mac_ucast_act           = "flood"
#   unk_mcast_act               = "flood"
#   v6unk_mcast_act             = "flood"
#   vmac                        = "not-applicable"
#     }

# resource "aci_application_epg" "devvie" {
#   application_profile_dn  = aci_application_profile.devvie.id
#   name                    = "devvie_epg"
#   relation_fv_rs_bd       = aci_bridge_domain.devvie.id
# }