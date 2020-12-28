#! /bin/bash
# Launcher for OpenAPI Generator

set -e

API_JSON_URL="http://localhost:3000/api/docs-json"
SCRIPT_DIR="$(cd $(dirname $0); pwd)"
SERVER_DIR="${SCRIPT_DIR}/../packages/server/"
CLIENT_DIR="${SCRIPT_DIR}/../packages/client/"

echo "Waiting for server..."
until curl --silent "${API_JSON_URL}"; do
  sleep 2
done

curl --silent "${API_JSON_URL}" > /tmp/api.json
"${SERVER_DIR}/node_modules/.bin/json2yaml" /tmp/api.json > /tmp/api.yaml
/opt/openapi-generator/docker-entrypoint.sh generate -i /tmp/api.yaml -g typescript-angular -o "${CLIENT_DIR}/src/.api-client/"