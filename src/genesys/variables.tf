
variable "oauth_client_name" {
  description = "Name for the Genesys Cloud OAuth client"
  type        = string
  default     = "ServiceNow Integration Client Automate"
}

variable "oauth_token_validity_seconds" {
  description = "Lifetime (in seconds) for tokens issued by this OAuth client"
  type        = number
  default    = 86400
}

variable "genesyscloud_region" {
  description = "AWS region where your Genesys Cloud org lives (e.g. us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "clientId" {
  description = "Client Id created from Genesys Cloud Oauth"
  type        = string
}

variable "clientSecret" {
  description = "Client secret created from Genesys Cloud Oauth"
  type        = string
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