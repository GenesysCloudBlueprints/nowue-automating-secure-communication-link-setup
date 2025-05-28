output "ca_private_key_pem" {
  description = "PEM-encoded CA private key"
  value       = tls_private_key.server.private_key_pem
  sensitive   = true
}

output "ca_certificate_pem" {
  description = "PEM-encoded CA certificate"
  value       = tls_self_signed_cert.ca.cert_pem
}

output "ca_certificate_path" {
  description = "Local path to the CA certificate file"
  value       = local_file.cert.filename
}

output "server_certificate_pem" {
  description = "PEM-encoded server certificate signed by the CA"
  value       = tls_locally_signed_cert.server.cert_pem
  sensitive   = false
}