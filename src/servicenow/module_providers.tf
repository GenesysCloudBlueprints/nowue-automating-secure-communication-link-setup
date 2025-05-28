terraform {
  required_providers {
    restapi    = { source = "Mastercard/restapi",     version = ">= 1.20.1" }
    servicenow = { source = "tylerhatton/servicenow",  version = "~> 0.9.5" }
  }
}

provider "restapi" {
  uri                   = "https://${var.sn_instance_url}/"
  username              = var.sn_username
  password              = var.sn_password
   headers = {
    "Content-Type" = "application/json"
  }

  create_returns_object = true
  write_returns_object  = true
  update_method  = "PUT"
}


provider "servicenow" {
  instance_url      = "https://${var.sn_instance_url}/"
  username          = var.sn_username
  password          = var.sn_password
}
