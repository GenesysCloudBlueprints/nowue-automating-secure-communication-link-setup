
output "oauth_entity_sys_id" {
  description = "Sys ID of the OAuth JWT API endpoint record in ServiceNow"
  value       = restapi_object.oauth_jwt_entity.id
}

output "jwt_verifier_map_sys_id" {
  description = "Sys ID of the JWT Verifier Map entry in ServiceNow"
  value       = restapi_object.jwt_verifier_map.id
}

output "integration_user_sys_id" {
  description = "Sys ID of the integration API user created in ServiceNow"
  value       = restapi_object.integration_user.id
}


#output "http_connection_id" {
#  description = "Sys ID of the Genesys Cloud HTTP connection in ServiceNow"
#  value       = servicenow_http_connection.genesys.id
#}

output "certificate_sys_id" {
  value = jsondecode(restapi_object.certificate.api_response).result.sys_id
}