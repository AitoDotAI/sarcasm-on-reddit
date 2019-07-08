# $match
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_search \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "from": "comments",
    "where": {
      "comment": { "$match": "cool" }
    }
  }
  '

# $has
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_search \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "from": "comments",
    "where": {
      "comment": { "$has": "cool" }
    }
  }
  '