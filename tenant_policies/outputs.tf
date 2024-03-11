output "common_tenant" {
  value = data.aci_tenant.common.id
}

output "common_vrf" {
  value = aci_vrf.common.id
}

output "devvie_tenant" {
  value = aci_tenant.devvie.id
}

output "devvie_vrf" {
  value = aci_vrf.devvie.id
}


output "established_ct" {
  value = aci_contract.est.id
}



