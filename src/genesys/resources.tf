# Create the Client Credentials OAuth client
resource "genesyscloud_oauth_client" "servicenow_integration" {
  name                          = var.oauth_client_name
  access_token_validity_seconds = var.oauth_token_validity_seconds
  authorized_grant_type         = "CLIENT-CREDENTIALS"
  state                         = "active"

  roles {
    role_id     = genesyscloud_auth_role.servicenow_integration_role.id
    division_id = var.division_id
  }
}

resource "genesyscloud_integration_credential" "credential" {
  credential_type_name = "pureCloudOAuthClient"
  fields = {
    clientId = var.clientId
    clientSecret = var.clientSecret
  }
}