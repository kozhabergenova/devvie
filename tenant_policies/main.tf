data "aci_tenant" "common" {
  name = "common"
}

resource "aci_vrf" "common" {
  tenant_dn = data.aci_tenant.common.id
  name      = "common"
}

resource "aci_tenant" "devvie" {
  name        = "devvie"
  description = "Tenant for Devvie"
}

resource "aci_vrf" "devvie" {
  tenant_dn   = aci_tenant.devvie.id
  name        = "devvie"
  description = "VRF for Devvie"
}

### Contract with Established Flag for vzAny

resource "aci_filter" "est" {
  tenant_dn = data.aci_tenant.common.id
  name      = "est"
}

resource "aci_filter_entry" "est" {
  name        = "est"
  filter_dn   = aci_filter.est.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "unspecified"
  d_to_port   = "unspecified"
  stateful    = "no"
  tcp_rules   = ["est"]
}

resource "aci_contract" "est" {
  tenant_dn = data.aci_tenant.common.id
  name      = "Established"
  scope     = "context"
}

resource "aci_contract_subject" "est" {
  contract_dn           = aci_contract.est.id
  name                  = "est_subj"
  rev_flt_ports         = "yes"
  apply_both_directions = "yes"
  relation_vz_rs_subj_filt_att = [
    aci_filter.est.id,
  ]
}

resource "aci_contract_subject_filter" "est" {
  contract_subject_dn = aci_contract_subject.est.id
  filter_dn           = aci_filter.est.id
  action              = "permit"
  priority_override   = "default"
}

resource "aci_any" "vzany" {
  match_t                    = "AtleastOne"
  pref_gr_memb               = "disabled"
  relation_vz_rs_any_to_cons = [aci_contract.est.id]
  relation_vz_rs_any_to_prov = [aci_contract.est.id]
  vrf_dn                     = aci_vrf.devvie.id
}

###