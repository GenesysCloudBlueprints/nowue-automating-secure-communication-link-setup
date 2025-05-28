# First create CA resources
resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = var.common_name
    organization = var.organization
  }
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.server.private_key_pem
  
  subject {
    common_name  = var.common_name
    organization = var.organization
  }
  
  validity_period_hours = var.validity_days * 24
  is_ca_certificate     = true
  
  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]
}

# Then use CA to sign server cert
resource "tls_locally_signed_cert" "server" {
  cert_request_pem      = tls_cert_request.server.cert_request_pem
  ca_private_key_pem    = tls_private_key.server.private_key_pem
  ca_cert_pem           = tls_self_signed_cert.ca.cert_pem   # This was missing
  validity_period_hours = var.validity_days * 24
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "local_file" "cert" {
  content         = tls_locally_signed_cert.server.cert_pem
  filename        = "${path.module}/server.crt"
  file_permission = "0644"
}

resource "local_file" "key" {
  content         = tls_private_key.server.private_key_pem
  filename        = "${path.module}/server.key"
  file_permission = "0600"
}