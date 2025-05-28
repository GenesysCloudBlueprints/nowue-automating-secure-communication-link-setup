variable "common_name" {
  description = "CSR Common Name (e.g. myinst.service-now.com)"
  type        = string
}

variable "organization" {
  description = "CSR Organization field"
  type        = string
}

variable "validity_days" {
  description = "Cert validity period (days)"
  type        = number
  default     = 365
}
