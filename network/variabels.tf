variable "name" {
  type = string
}

variable "vlan_id" {
  type = number
}

variable "gateway_address" {
  type = string
}

variable "physical_domain" {
  type = string
}

### List of domain applicable to the capability of the EPGs subnet.
### Allowed values are "public", "private" and "shared".
variable "route_scope" {
  type = list(string)
}

variable "provided_contract" {
  type = string
}

variable "mode" {
  type = string
  default = "regular"
}

variable "tenant_os" {
  type = string
}

variable "vrf_os" {
  type = string
}

variable "aep_access" {
  type = string
}