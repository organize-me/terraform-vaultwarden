provider "postgresql" {
  host = var.postgres_host
  port = var.postgres_port
  username = var.postgres_root_user
  password = var.postgres_root_password
  sslmode = "disable"

}

# Create the database
resource "postgresql_database" "vaultwarden" {
  name = var.vaultwarden_db_username
}

# Create a PostgreSQL user
resource "postgresql_role" "vaultwarden" {
  name     = var.vaultwarden_db_username
  password = var.vaultwarden_db_password
  login    = true
}

# Grant privileges to the PostgreSQL user
resource "postgresql_grant" "vaultwarden" {
  role        = postgresql_role.vaultwarden.name
  database    = postgresql_database.vaultwarden.name
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]

  depends_on = [postgresql_database.vaultwarden, postgresql_role.vaultwarden]
}