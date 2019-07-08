# See what features correlate with comment being sarcastic
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_relate \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "from": "comments",
    "relate": [{
      "label": 1
    }]
  }
  '

# Limit the examination to 2-grams
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_relate \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "from": "comments",
    "where": { "$exists": "comment_2grams" },
    "relate": [{
      "label": 1
    }]
  }
  '
