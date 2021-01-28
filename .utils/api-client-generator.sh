#! /bin/bash
# Launcher for OpenAPI Generator

set -e

API_JSON_URL="http://localhost:3000/api/docs-json"
TMP_DIR="/tmp/"
SCRIPT_DIR="$(cd $(dirname $0); pwd)"
SERVER_DIR="${SCRIPT_DIR}/../packages/server/"
CLIENT_DIR="${SCRIPT_DIR}/../packages/client/"

# Get the previous hash sum of the API JSON
API_JSON_HASH_OLD=""
if [ -f "${TMP_DIR}api.json" ]; then
  API_JSON_HASH_OLD=`sha1sum "${TMP_DIR}api.json" | awk '{ print $1 }'`
fi

# Check if the API client exists
EXISTS_API_CLIENT=0
if [ -f "${CLIENT_DIR}/src/.api-client/index.ts" ]; then
  EXISTS_API_CLIENT=1
fi

# Check the argument
if [ "${1}" = "online" ]; then
  # Get the API JSON from the running server
  echo "Waiting for server..."
  sleep 2
  until curl --silent "${API_JSON_URL}" > /dev/null; do
    sleep 2
  done
  curl --silent "${API_JSON_URL}" > /tmp/api.json
else
  # Get the API JSON without starting the server
  ts-node -r tsconfig-paths/register "${SERVER_DIR}src/openapi-doc-generator.ts" "--output=${TMP_DIR}api.json"
fi

# Check if there is a difference between the new and old API JSON
API_JSON_HASH_NEW=`sha1sum "${TMP_DIR}api.json" | awk '{ print $1 }'`
if [ $EXISTS_API_CLIENT -eq 1 -a "${API_JSON_HASH_OLD}" = "${API_JSON_HASH_NEW}" ]; then
  exit 0
fi

# Covnert API JSON to YAML
json2yaml "${TMP_DIR}/api.json" > "${TMP_DIR}/api.yaml"

# Generate the API client
/opt/openapi-generator/docker-entrypoint.sh generate -i "${TMP_DIR}/api.yaml" -g typescript-angular -o "${CLIENT_DIR}/src/.api-client/" || rm "${TMP_DIR}api.json"
exit 0