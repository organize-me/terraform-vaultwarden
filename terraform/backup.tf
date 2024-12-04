# Script to run the backup script as a Docker container
resource "local_file" "backup_script" {
  filename = "${var.backup_install_path}/vaultwarden-backup.sh"
  content = templatefile("./backup/backup.sh.tftpl", {
    TF_BACKUP_TMP_DIR             = abspath(var.backup_tmp_dir)
    TF_ARCHIVE_NAME               = var.backup_archive_name
    TF_S3_BACKUP_BUCKET           = var.backup_s3_bucket
    TF_AWS_CLI_IMAGE              = var.backup_docker_aws_image
    TF_DOCKER_NETWORK_NAME        = data.docker_network.network.name
    TF_VAULTWARDEN_CONTAINER_NAME = docker_container.vaultwarden.name
    TF_VAULTWARDEN_VOLUME         = docker_volume.vaultwarden.name
    TF_POSTGRES_IMAGE             = var.backup_docker_postgres_image
    TF_POSTGRES_HOST              = var.vaultwarden_db_host
    TF_POSTGRES_PORT              = var.vaultwarden_db_port
    TF_POSTGRES_USERNAME          = var.vaultwarden_db_username
    TF_POSTGRES_PASSWORD          = var.vaultwarden_db_password
    TF_POSTGRES_DB                = postgresql_database.vaultwarden.name
    TF_POSTGRES_DUMP_NAME         = "vaultwarden.sql"
  })
}

# Make the backup script executable
resource "null_resource" "backup_chmod" {
  provisioner "local-exec" {
    command = "chmod +x ${local_file.backup_script.filename}"
  }

  triggers = {
    md5 = local_file.backup_script.content_md5
  }

  depends_on = [local_file.backup_script]
}

# Script to run the restore script as a Docker container
resource "local_file" "restore_script" {
  filename = "${var.backup_install_path}/vaultwarden-restore.sh"
  content = templatefile("./backup/restore.sh.tftpl", {
    TF_BACKUP_TMP_DIR             = abspath(var.backup_tmp_dir)
    TF_VAULTWARDEN_CONTAINER_NAME = docker_container.vaultwarden.name
    TF_S3_BACKUP_BUCKET           = var.backup_s3_bucket
    TF_AWS_CLI_IMAGE              = var.backup_docker_aws_image
    TF_ARCHIVE_NAME               = var.backup_archive_name
    TF_DOCKER_NETWORK_NAME        = data.docker_network.network.name
    TF_POSTGRES_HOST              = var.vaultwarden_db_host
    TF_POSTGRES_PORT              = var.vaultwarden_db_port
    TF_POSTGRES_IMAGE             = var.backup_docker_postgres_image
    TF_POSTGRES_USERNAME          = var.vaultwarden_db_username
    TF_POSTGRES_PASSWORD          = var.vaultwarden_db_password
    TF_POSTGRES_DB                = postgresql_database.vaultwarden.name
    TF_POSTGRES_DUMP_NAME         = "vaultwarden.sql"
    TF_VAULTWARDEN_VOLUME         = docker_volume.vaultwarden.name
  })
}

# Make the backup script executable
resource "null_resource" "restore_chmod" {
  provisioner "local-exec" {
    command = "chmod +x ${local_file.restore_script.filename}"
  }

  triggers = {
    md5 = local_file.restore_script.content_md5
  }

  depends_on = [local_file.restore_script]
}