terraform {
  required_providers {
    tls        = { source = "hashicorp/tls",       version = "~> 4.0"   }
    local      = { source = "hashicorp/local",       version = "~> 2.0"   }
    restapi    = { source = "Mastercard/restapi",    version = ">= 1.20.1" }
    servicenow = { source = "tylerhatton/servicenow", version = "~> 0.9.5" }
    genesyscloud = { source = "MyPureCloud/genesyscloud", version = ">= 1.61.0" }

  }
}

provider "restapi" {
  uri                   = "https://${var.sn_instance_url}/"
  username              = var.sn_username
  password              = var.sn_password
  insecure              = true
  create_returns_object = true
  write_returns_object  = true
  headers = {
    "Content-Type" = "application/json"
  }
  update_method  = "PUT"
}

provider "servicenow" {
  instance_url      = "https://${var.sn_instance_url}/"
  username          = var.sn_username
  password          = var.sn_password
}

provider "genesyscloud" {
  aws_region    =  var.genesyscloud_region
}