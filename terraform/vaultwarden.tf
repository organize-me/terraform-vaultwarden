resource "docker_image" "vaultwarden" {
  name = var.vaultwarden_image
}

# Create a volume for the pihole configuration
resource "docker_volume" "vaultwarden" {
  name = "vaultwarden_data"
}

resource "docker_container" "vaultwarden" {
  image        = docker_image.vaultwarden.image_id
  name         = "organize-me-vaultwarden"
  hostname     = "vaultwarden"
  restart      = "unless-stopped"
  network_mode = "bridge"

  env = [
    "TZ=${var.timezone}",
    "DOMAIN=${var.vaultwarden_domain}",
    "DATABASE_URL=postgresql://${var.vaultwarden_db_username}:${var.vaultwarden_db_password}@${var.vaultwarden_db_host}:${var.vaultwarden_db_port}/${postgresql_database.vaultwarden.name}",
    "LOGIN_RATELIMIT_MAX_BURST=10",
    "LOGIN_RATELIMIT_SECONDS=60",
    "ADMIN_RATELIMIT_MAX_BURST=10",
    "ADMIN_RATELIMIT_SECONDS=60",
    "ADMIN_TOKEN=${var.vaultwarden_admin_token}",
    "SENDS_ALLOWED=true",
    "EMERGENCY_ACCESS_ALLOWED=false",
    "WEB_VAULT_ENABLED=true",
    "SIGNUPS_ALLOWED=false",
    "SIGNUPS_VERIFY=true",
    "SIGNUPS_VERIFY_RESEND_TIME=3600",
    "SIGNUPS_VERIFY_RESEND_LIMIT=5",
    "SIGNUPS_DOMAINS_WHITELIST=",
    "SMTP_HOST=${var.smtp_host}",
    "SMTP_FROM=${var.smtp_reply_address}",
    "SMTP_FROM_NAME=noreply",
    "SMTP_SECURITY=starttls",
    "SMTP_PORT=${var.smtp_port}",
    "SMTP_USERNAME=${var.smtp_username}",
    "SMTP_PASSWORD=${var.smtp_password}",
    "SMTP_AUTH_MECHANISM=Login",
    "SMTP_ACCEPT_INVALID_CERTS=true"
  ]

  networks_advanced {
    name = data.docker_network.network.name
    aliases = [var.vaultwarden_network_alias]
  }

  volumes {
    container_path = "/data"
    volume_name    = docker_volume.vaultwarden.name
    read_only      = false
  }

  ports {
    internal = 80
    external = 8080
  }

  depends_on = [postgresql_grant.vaultwarden]
}