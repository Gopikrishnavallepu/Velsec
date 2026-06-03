variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "tunnel_secret" {
  description = "32-byte base64 encoded secret for the tunnel"
  type        = string
  sensitive   = true
}
