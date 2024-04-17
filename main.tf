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
  server_url           = "http://54.196.115.176:8000"
  allow_insecure_https = "true"
  skip_version_check   = "true"
}

terraform {
  backend "s3" {
    bucket = "github-pub-tf-state"
    region = "us-east-1"
    # Environment variable for key is AWS_BUCKET_KEY_NAME
  }
}

