variable "sn_instance_url" {
  description = "Your ServiceNow instance hostname (e.g. myinst.service-now.com)"
  type        = string
}

variable "sn_username" {
  description = "ServiceNow API user (needs write to sys_certificate)"
  type        = string
  sensitive   = true
}

variable "sn_password" {
  description = "Password for the ServiceNow API user"
  type        = string
  sensitive   = true
}

variable "cert_password" {
  description = "Passphrase for encrypting the private key"
  type        = string
  sensitive   = true
}

variable "cert_name" {
  description = "Name for the sys_certificate record in ServiceNow"
  type        = string
}

variable "oauth_name" {
  description = "Unique name for the OAuth JWT API endpoint"
  type        = string
}

variable "genesys_api_url" {
  description = "Base URL for the Genesys Cloud API (e.g. https://api.mypurecloud.com)"
  type        = string
}

variable "integration_user_id" {
  description = "Login (user_name) for the integration API user"
  type        = string
}

variable "integration_user_first_name" {
  description = "First name for the integration API user"
  type        = string
}

variable "integration_user_last_name" {
  description = "Last name for the integration API user"
  type        = string
}

variable "jwt_verifier_name" {
  description = "Name for the JWT Verifier Map"
  type        = string
}

variable "certificate_pem" {
  type        = string
  description = "PEM cert from certs module"
}

variable "genesys_oauth_client_id" {
  description = "Client ID from the Genesys Cloud OAuth client"
  type        = string
}

variable "genesys_oauth_client_secret" {
  description = "Client Secret from the Genesys Cloud OAuth client"
  type        = string
  sensitive   = true
}


variable "connection_alias" {
  description = "ServiceNow connection and credentials alias"
  type        = string
  sensitive   = true
}
