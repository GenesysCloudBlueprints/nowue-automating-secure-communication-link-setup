terraform {
  required_providers {
    genesyscloud = { source = "MyPureCloud/genesyscloud", version = ">= 1.61.0" }
  }
}

provider "genesyscloud" {
  aws_region    = var.genesyscloud_region
  oauthclient_id     = var.clientId
  oauthclient_secret = var.clientSecret
}