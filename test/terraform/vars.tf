variable "timezone" {
  type = string
  default = "America/Los_Angeles"
}

# --== SMTP Variables ==--
variable "smtp_port" {
  type = string
}
variable "smtp_username" {
  type = string
}
variable "smtp_password" {
  type = string
}

variable "docker_host" {
  type = string
  default = "unix:///var/run/docker.sock"
}
variable "docker_network" {
  type = string
}


variable "backup_docker_postgres_image" {
  type = string
  default = "postgres:17"
}

variable "postgres_port" {
  type = string
}
variable "postgres_root_username" {
  description = "The PostgreSQL username"
  type        = string
}
variable "postgres_root_password" {
  description = "The PostgreSQL password"
  type        = string
}

variable "minio_docker_image" {
  type = string
}
variable "minio_root_user" {
  description = "The MinIO username"
  type        = string
}
variable "minio_root_password" {
  description = "The MinIO password"
  type        = string
}
variable "backup_s3_bucket" {
  description = "The S3 bucket to store backups"
  type        = string
}