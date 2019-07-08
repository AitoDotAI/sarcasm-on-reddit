curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_search \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "from": "comments",
    "where": {
      "label": 0
    },
    "limit": 1
  }
  '