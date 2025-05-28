output "genesyscloud_oauth_client_id" {
  description = "Client ID for the ServiceNow integration"
  value       = genesyscloud_integration_credential.credential.fields["clientId"]
}

output "genesyscloud_oauth_client_secret" {
  description = "Client Secret (use this in your ServiceNow Connection & Credential)"
  value       = genesyscloud_integration_credential.credential.fields["clientSecret"]
  sensitive   = true
}