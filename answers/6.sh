# Just based on the comment
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_evaluate \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "test": {
      "$index": {
        "$mod": [10, 0]
      }
    },
    "evaluate": {
      "from": "comments",
      "where": {
        "comment": { "$get": "comment" }
      },
      "predict": "label"
    }
  }
  '


# Take comment, comment_2grams, comment_whitespace, and comment_has_upper_case_word into account
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_evaluate \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "test": {
      "$index": {
        "$mod": [10, 0]
      }
    },
    "evaluate": {
      "from": "comments",
      "where": {
        "comment": { "$get": "comment" },
        "comment_2grams": { "$get": "comment_2grams" },
        "comment_whitespace": { "$get": "comment_whitespace" },
        "comment_has_upper_case_word": { "$get": "comment_has_upper_case_word" }
      },
      "predict": "label"
    }
  }
  '

# Just based on the author (poor accuracy but for demonstration)
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_evaluate \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "test": {
      "$index": {
        "$mod": [10, 0]
      }
    },
    "evaluate": {
      "from": "comments",
      "where": {
        "author": { "$get": "author" }
      },
      "predict": "label"
    }
  }
  '
