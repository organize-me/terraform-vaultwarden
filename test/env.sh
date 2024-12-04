# Set the aws-cli environment variables
export AWS_ACCESS_KEY_ID="minioadmin"
export AWS_SECRET_ACCESS_KEY="minioadmin"
export AWS_S3_ENDPOINT_URL="http://host.docker.internal:9000"

export TF_VAR_docker_network="test"
export TF_VAR_docker_host="unix://$HOME/.docker/desktop/docker.sock"
export TF_VAR_postgres_host="localhost"
export TF_VAR_postgres_port=5432
export TF_VAR_postgres_root_username="admin"
export TF_VAR_postgres_root_password="password"
export TF_VAR_smtp_host="smtp"
export TF_VAR_smtp_port="1025"
export TF_VAR_smtp_username="admin"
export TF_VAR_smtp_password="password"
export TF_VAR_smtp_reply_address="noreply@localhost"
export TF_VAR_vaultwarden_admin_token="admin"
export TF_VAR_vaultwarden_db_host="postgres"
export TF_VAR_vaultwarden_db_port=$TF_VAR_postgres_port
export TF_VAR_vaultwarden_db_username="vaultwarden"
export TF_VAR_vaultwarden_db_password="password"
export TF_VAR_vaultwarden_domain="http://localhost:8080"
export TF_VAR_backup_install_path="../tmp/install"
export TF_VAR_backup_tmp_dir="../tmp/backup"

export TF_VAR_minio_docker_image="minio/minio:latest"
export TF_VAR_minio_root_user="$AWS_ACCESS_KEY_ID"
export TF_VAR_minio_root_password="$AWS_SECRET_ACCESS_KEY"
export TF_VAR_backup_s3_bucket="vaultwarden-backups"