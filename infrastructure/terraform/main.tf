terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
  description = "API Token for Cloudflare"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Cloudflare Zone ID for velsec.com"
  type        = string
}

# Create a Cloudflare Zero Trust Tunnel for the Raspberry Pi
resource "cloudflare_argo_tunnel" "rpi_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "velsec-onprem-k3s"
  secret     = var.tunnel_secret
}

# Route the root domain to the tunnel
resource "cloudflare_record" "root_domain" {
  zone_id = var.zone_id
  name    = "velsec.com"
  value   = "${cloudflare_argo_tunnel.rpi_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

# Route wildcard subdomains to the tunnel
resource "cloudflare_record" "wildcard_domain" {
  zone_id = var.zone_id
  name    = "*"
  value   = "${cloudflare_argo_tunnel.rpi_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
