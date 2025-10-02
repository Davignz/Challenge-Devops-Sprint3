MYSQL_HOST=$(az mysql flexible-server show -g "$RESOURCE_GROUP" -n "$MYSQL_NAME" --query "fullyQualifiedDomainName" -o tsv)
CONN_STR="Server=${MYSQL_HOST};Database=${MYSQL_DB};User Id=${MYSQL_ADMIN_USER};Password=${MYSQL_ADMIN_PASSWORD};SslMode=Preferred"

docker run --rm -p ${APP_PORT}:8080 \
  -e ConnectionStrings__DefaultConnection="$CONN_STR" \
  "$IMAGE_NAME:$IMAGE_TAG"
