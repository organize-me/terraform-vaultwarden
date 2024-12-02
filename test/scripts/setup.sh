#!/bin/bash

# CD into the directory of the script
cd "$(dirname "$0")" || exit 1
SCRIPT_DIR="$(pwd)"
echo "$SCRIPT_DIR"

# Set environment variables
cd "$SCRIPT_DIR" || exit 1
cd ../ || exit 1
echo "$PWD"
source ./env.sh

# Setup dependent infrastructure
cd "$SCRIPT_DIR" || exit 1
cd ../terraform || exit 1
echo "$PWD"
terraform init --input=false || exit 1
terraform apply --input=false -auto-approve || exit 1

# Setup vaultwarden
cd "$SCRIPT_DIR" || exit 1
cd ../../terraform || exit 1
echo "$PWD"
terraform init --input=false || exit 1
terraform apply --input=false -auto-approve || exit 1
