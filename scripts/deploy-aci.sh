
LOGIN_SERVER=$(az acr show -n "$ACR_NAME" --query loginServer -o tsv)
ACR_USER=$(az acr credential show -n "$ACR_NAME" --query "username" -o tsv)
ACR_PWD=$(az acr credential show -n "$ACR_NAME" --query "passwords[0].value" -o tsv)

MYSQL_HOST=$(az mysql flexible-server show -g "$RESOURCE_GROUP" -n "$MYSQL_NAME" --query "fullyQualifiedDomainName" -o tsv)

CONN_STR="Server=${MYSQL_HOST};Database=${MYSQL_DB};User Id=${MYSQL_ADMIN_USER};Password=${MYSQL_ADMIN_PASSWORD};SslMode=Preferred"

az container create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$ACI_NAME" \
  --image "$LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG" \
  --registry-login-server "$LOGIN_SERVER" \
  --registry-username "$ACR_USER" \
  --registry-password "$ACR_PWD" \
  --ports "$APP_PORT" \
  --ip-address Public \
  --cpu 1 --memory 1.5 \
  --environment-variables "ConnectionStrings__DefaultConnection=$CONN_STR"

echo "Aguardando o provisionamento..."
az container show -g "$RESOURCE_GROUP" -n "$ACI_NAME" --query "{state:provisioningState,ip:ipAddress.ip}" -o tsv
