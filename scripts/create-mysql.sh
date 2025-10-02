#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../.env"

az account set --subscription "$SUBSCRIPTION_ID"

# Criação do MySQL Flexible Server com acesso público (atenção: para fins acadêmicos)
az mysql flexible-server create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$MYSQL_NAME" \
  --location "$LOCATION" \
  --admin-user "$MYSQL_ADMIN_USER" \
  --admin-password "$MYSQL_ADMIN_PASSWORD" \
  --version "$MYSQL_VERSION" \
  --public-access all \
  --tier Burstable --sku-name Standard_B1ms --storage-size 20

# Cria o banco de dados
az mysql flexible-server db create -g "$RESOURCE_GROUP" -s "$MYSQL_NAME" -d "$MYSQL_DB"

# Aplica DDL e seed usando o cliente mysql (requer que você tenha o mysql-client instalado localmente)
MYSQL_HOST="$(az mysql flexible-server show -g "$RESOURCE_GROUP" -n "$MYSQL_NAME" --query "fullyQualifiedDomainName" -o tsv)"
echo "MySQL HOST: $MYSQL_HOST"

echo "Aplicando DDL..."
mysql -h "$MYSQL_HOST" -u "$MYSQL_ADMIN_USER" -p"$MYSQL_ADMIN_PASSWORD" < "$(dirname "$0")/../script_bd.sql"

echo "Aplicando SEED..."
mysql -h "$MYSQL_HOST" -u "$MYSQL_ADMIN_USER" -p"$MYSQL_ADMIN_PASSWORD" < "$(dirname "$0")/../seed_bd.sql"

echo "Concluído."
