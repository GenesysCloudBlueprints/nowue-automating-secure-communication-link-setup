# ── Certs Module Inputs ─────────────────────────────────────────────────────

variable "common_name" {
  description = "CSR Common Name (e.g. myinst.service-now.com)"
  type        = string
}

variable "organization" {
  description = "CSR Organization field"
  type        = string
}

variable "validity_days" {
  description = "Certificate validity period (in days)"
  type        = number
  default     = 365
}

# ── Genesys Cloud Module Inputs ─────────────────────────────────────────────
variable "oauthclient_id" {
  description = "Client Id created from Genesys Cloud Oauth"
  type        = string
}

variable "oauthclient_secret" {
  description = "Client secret created from Genesys Cloud Oauth"
  type        = string
}

variable "genesyscloud_region" {
  description = "Region your Genesys Cloud org lives in (e.g. us-east-1)"
  type        = string
}

variable "oauth_client_name" {
  description = "Name for the Genesys Cloud OAuth client"
  type        = string
}

variable "oauth_token_validity_seconds" {
  description = "Lifetime (in seconds) for tokens issued by this OAuth client"
  type        = number
  default     = 86400
}

variable "division_id" {
  description = "Division in which to assign the integration role"
  type        = string
  default     = "Home"
}

variable "role_id" {
  description = "Role id in which to assign the integration role"
  type        = string
  default     = "Home"
}

# ── ServiceNow Module Inputs ────────────────────────────────────────────────

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

variable "cert_name" {
  description = "Name for the sys_certificate record in ServiceNow"
  type        = string
}

variable "cert_password" {
  description = "Passphrase for encrypting the private key"
  type        = string
  sensitive   = true
}

variable "oauth_name" {
  description = "Unique name for the OAuth JWT API endpoint in ServiceNow"
  type        = string
}

variable "jwt_verifier_name" {
  description = "Name for the JWT Verifier Map entry in ServiceNow"
  type        = string
}

variable "integration_user_id" {
  description = "Login (user_name) for the integration API user in ServiceNow"
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

variable "genesys_api_url" {
  description = "Base URL for the Genesys Cloud API (e.g. https://api.mypurecloud.com)"
  type        = string
}

variable "connection_alias" {
  type        = string
  description = "ServiceNow connection and credentials alias"
}

