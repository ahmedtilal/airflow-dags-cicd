#!/bin/sh

set -a
. ./.env
set +a

cat <<EOF
{
  "github_token": "$GITHUB_TOKEN"
}
EOF