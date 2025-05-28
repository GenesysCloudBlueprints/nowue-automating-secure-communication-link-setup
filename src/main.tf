module "certs" {
  source       = "./certs"
  common_name  = var.common_name
  organization = var.organization
  validity_days = var.validity_days
}

module "genesys" {
  source                       = "./genesys"
  clientId                     = var.oauthclient_id
  clientSecret                 = var.oauthclient_secret
  genesyscloud_region          = var.genesyscloud_region
  oauth_client_name            = var.oauth_client_name
  oauth_token_validity_seconds = var.oauth_token_validity_seconds
  division_id                  = var.division_id
  role_id                      = var.role_id
}

module "servicenow" {
  source                      = "./servicenow"
  sn_instance_url             = var.sn_instance_url
  sn_username                 = var.sn_username
  sn_password                 = var.sn_password
  certificate_pem             = module.certs.ca_certificate_pem 
  cert_name                   = var.cert_name
  connection_alias            = var.connection_alias
  cert_password               = var.cert_password
  oauth_name                  = var.oauth_name
  jwt_verifier_name           = var.jwt_verifier_name
  integration_user_id         = var.integration_user_id
  integration_user_first_name = var.integration_user_first_name
  integration_user_last_name  = var.integration_user_last_name
  genesys_api_url             = var.genesys_api_url
  genesys_oauth_client_id     = module.genesys.genesyscloud_oauth_client_id
  genesys_oauth_client_secret = module.genesys.genesyscloud_oauth_client_secret

}