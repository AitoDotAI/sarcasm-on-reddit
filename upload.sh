#!/bin/bash

set -e

export AITO_ENV=aito-reddit-sarcasm

head -n 1 train-balanced-sarcasm.csv > train-balanced-sarcasm-small.csv
grep -i "^0" train-balanced-sarcasm.csv | head -n 5000 >> train-balanced-sarcasm-small.csv
grep -i "^1" train-balanced-sarcasm.csv | head -n 5000 >> train-balanced-sarcasm-small.csv

csvtojson train-balanced-sarcasm-small.csv > comments.json
jq -c '.[] | . + {label: (.label)|tonumber, score: (.score)|tonumber, ups: (.ups)|tonumber, downs: (.downs)|tonumber}' comments.json > step1.ndjson

cat step1.ndjson | node transform.js > comments.ndjson

curl -O https://raw.githubusercontent.com/AitoDotAI/aito-tools/master/upload-file.sh

curl -X DELETE \
  https://$AITO_ENV.api.aito.ai/api/v1/schema \
  -H "x-api-key: $API_KEY"

curl -X PUT \
  https://$AITO_ENV.api.aito.ai/api/v1/schema \
  -H "content-type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d@schema.json

bash upload-file.sh comments.ndjson https://$AITO_ENV.api.aito.ai
