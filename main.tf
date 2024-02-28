
provider "aci" {
  username = var.aci_username
  password = var.aci_password
  url      = "https://sandboxapicdc.cisco.com/"
  insecure = true
}

provider "fmc" {
  fmc_host                 = "fmcrestapisandbox.cisco.com"
  fmc_insecure_skip_verify = true
}

provider "netbox" {
  server_url = "http://0.0.0.0:8000"
  allow_insecure_https = "true"
}
