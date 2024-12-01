# --== General Variables ==--
variable "timezone" {
  type = string
  default = "America/Los_Angeles"
}

# --== SMTP Variables ==--
variable "smtp_host" {
  type = string
}
variable "smtp_port" {
  type = string
}
variable "smtp_username" {
  type = string
}
variable "smtp_password" {
  type = string
}
variable "smtp_reply_address" {
  type = string
}

# --== Docker Variables ==--
variable "docker_host" {
  type = string
  default = "unix:///var/run/docker.sock"
}
variable "docker_network" {
  type = string
}

# --== PostgreSQL Variables ==--
variable "postgres_host" {
  type = string
}
variable "postgres_port" {
  type = string
}
variable "postgres_root_user" {
  type = string
}
variable "postgres_root_password" {
  type = string
}

# --== Vaultwarden Variables ==--
variable "vaultwarden_image" {
  type = string
  default = "vaultwarden/server:1.32.4"
}
variable "vaultwarden_db_host" {
  type = string
}
variable "vaultwarden_db_port" {
  type = string
}
variable "vaultwarden_db_username" {
  type = string
}
variable "vaultwarden_db_password" {
  type = string
}
variable "vaultwarden_admin_token" {
  type = string
}
variable "vaultwarden_domain" {
  type = string
}

# --== Backup/Restore Variables ==--
variable "backup_docker_postgres_image" {
  type = string
  default = "postgres:17"
}