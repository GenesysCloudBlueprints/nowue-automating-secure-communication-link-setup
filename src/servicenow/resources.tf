# Upload X.509 cert
resource "restapi_object" "certificate" {
  path         = "/api/now/table/sys_certificate"
  id_attribute = "result/sys_id"
  debug        = true

  data = jsonencode({
    name            = var.cert_name
    format          = "PEM"
    type            = "Trust Store Cert"
    pem_certificate = "${var.certificate_pem}"
    active          = "true"
    user_field      = "sys_id"
  })
}

output "certificate_response" {
  value = restapi_object.certificate.api_response
}

resource "restapi_object" "oauth_jwt_entity" {
  path        = "/api/now/table/oauth_jwt"
  id_attribute = "result/sys_id"

  data = jsonencode({
    name                    = var.oauth_name
    user_field              = "sys_id"
    active                  = "true"
    default_grant_type      = "jwt_bearer"
  })
}

locals {
  certificate_sys_id = restapi_object.certificate.id
}

# JWT Verifier map
resource "restapi_object" "jwt_verifier_map" {
  path        = "/api/now/table/jwt_verifier_map"
  depends_on = [restapi_object.oauth_jwt_entity]
  id_attribute = "result/sys_id"


  data = jsonencode({
    name            = var.jwt_verifier_name
    oauth_jwt       = restapi_object.oauth_jwt_entity.id
    sys_certificate = local.certificate_sys_id
  })
}

# Integration user + roles
resource "restapi_object" "integration_user" {
  path        = "/api/now/table/sys_user"
  id_attribute = "result/sys_id"

  data = jsonencode({
    user_name                 = "${var.integration_user_id}"
    first_name                = "${var.integration_user_first_name}"
    last_name                 = "${var.integration_user_last_name}"
    active                    = "true"
    internal_integration_user = "true"
  })
}

# Define servicenow_role resources for each required role
locals {
  role_suffixes = [
    "awa_integration_user",
    "awa_external_user",
    "interaction_admin",
    "interaction_agent",
    "interaction_integration_user",
    "sn_openframe_api_user",
  ]
}

#Data‐source: look up each role by name ####
data "restapi_object" "roles" {
  for_each     = toset(local.role_suffixes)
  path         = "/api/now/table/sys_user_role"
  search_key   = "name"
  search_value = each.value
  results_key  = "result"
  id_attribute = "sys_id"
}


locals {
  user_sys_id = restapi_object.integration_user.id
}


resource "restapi_object" "user_role_assignments" {
  for_each     = data.restapi_object.roles

  path         = "/api/now/table/sys_user_has_role"
  create_path  = "/api/now/table/sys_user_has_role"
  id_attribute = "result/sys_id"

  data = jsonencode({
    user = local.user_sys_id
    role = each.value.id
  })

  # ensure the roles actually exist before assigning
  depends_on = [data.restapi_object.roles]
}

resource "restapi_object" "oauth_provider" {
  path         = "/api/now/table/oauth_entity"
  id_attribute = "result/sys_id"                        
  data = jsonencode({
    name               = "Genesys Cloud Spoke Connection - Automate"
    client_id          = var. genesys_oauth_client_id  
    client_secret      = var.genesys_oauth_client_secret
    default_grant_type = "client_credentials"
    type               = "oauth_provider"
    token_url          = "https://login.${var.genesys_api_url}/oauth/token"
  })
}

resource "restapi_object" "oauth_entity_profile" {
  path         = "/api/now/table/oauth_entity_profile"
  id_attribute = "result/sys_id"
  data = jsonencode({
    name          = "Genesys Cloud OAuth Profile"
    oauth_entity   = restapi_object.oauth_provider.id   
    grant_type    = "client_credentials"
  })
  depends_on = [restapi_object.oauth_provider]
}

resource "restapi_object" "oauth2_credentials" {
  path         = "/api/now/table/oauth_2_0_credentials"
  id_attribute = "result/sys_id"
  data = jsonencode({
    name                 = "Crediatials HTTP Connection"
    oauth_entity_profile = restapi_object.oauth_entity_profile.id
  })
  depends_on = [restapi_object.oauth_entity_profile]
}

resource "restapi_object" "https_connection" {
  path         = "/api/now/table/http_connection"
  id_attribute = "result/sys_id" 
  
  data = jsonencode({
    connection_alias       = var.connection_alias
    connection_url         = "https://api.${var.genesys_api_url}"
    credential             =  restapi_object.oauth2_credentials.id
    name                   = "Genesys Cloud Spoke Connection-valid"
    })
    depends_on = [
      restapi_object.oauth2_credentials
    ]
}