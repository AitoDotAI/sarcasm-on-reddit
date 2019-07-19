# Sarcasm on Reddit

This repository contains information and exercises to explore the
[Sarcasm on Reddit](https://www.kaggle.com/danofer/sarcasm) dataset.

## Key information

- The read-only API key is `9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV`
- The environment is served at https://aito-reddit-sarcasm.api.aito.ai
- Aito [documentation](https://aito.ai/docs/) and [API docs](https://aito.ai/docs/api/) are good resources
- You can use our hosted [Swagger UI](https://aito.ai/docs/swagger/?aitoEnv=aito-reddit-sarcasm) to do queries from browser
- The data preparation / upload is explained in [Initial Aito setup](https://github.com/AitoDotAI/sarcasm-on-reddit#initial-aito-setup) chapter

### Curl reference

Here's a curl command to list rows in `comments` table _(default limit is 10 results)_.

```bash
curl -X POST \
  https://aito-reddit-sarcasm.api.aito.ai/api/v1/_search \
  -H "content-type: application/json" \
  -H "x-api-key: 9Ik1wJQ1tq86vMQG7taDB2cgfpSogUFu69lBGTnV" \
  -d '
  {
    "from": "comments"
  }
  '
```

## Exploration exercises

Contains exercises you can try to explore the Sarcasm on Reddit dataset. Note that we've reduced
the data to 10k comments (original is 1.3M) in the publicly shared instance.

### 1. Search for comments which are labeled sarcastic

Hint: API documentation. This helps to understand the labeling distribution.


**The repsonse you should see**

```js
{
  "offset": 0,
  "total": 5000,
  "hits": [
    {
      "author": "RoguishPoppet",
      "comment": "But they'll have all those reviews!",
      "comment_2grams": "but-they'll they'll-have have-all all-those those-reviews!",
      "comment_has_upper_case_word": false,
      "comment_whitespace": "But they'll have all those reviews!",
      "date": "2016-11",
      "downs": -1,
      "label": 1,
      "parent_comment": "The dumb thing is, they are risking their seller account, too.",
      "score": 0,
      "subreddit": "ProductTesting",
      "ups": -1
    }
  ]
}
```


### 2. Search for comments which have the word "cool" in them

Hint: Text operators


**The repsonse you should see**

```js
{
  "offset" : 0,
  "total" : 33,
  "hits" : [ {
    "author" : "Lolwhatisfire",
    "comment" : "Zip lines are cool, but I'm more interested in what appears to be a swimming pool underneath her that is larger than my hometown.",
    "comment_2grams" : "zip-lines lines-are are-cool, cool,-but but-i'm i'm-more more-interested interested-in in-what what-appears appears-to to-be be-a a-swimming swimming-pool pool-underneath underneath-her her-that that-is is-larger larger-than than-my my-hometown.",
    "comment_has_upper_case_word" : false,
    "comment_whitespace" : "Zip lines are cool, but I'm more interested in what appears to be a swimming pool underneath her that is larger than my hometown.",
    "date" : "2016-11",
    "downs" : -1,
    "label" : 0,
    "parent_comment" : "Dubai Zipline",
    "score" : 15,
    "subreddit" : "gifs",
    "ups" : -1
  },
  ...
```

### 3. Search for the most upvoted sarcastic comment in "AskReddit" subreddit

No hint.


**The repsonse you should see**

```js
{
  "offset" : 0,
  "total" : 262,
  "hits" : [ {
    "$sort" : 90,
    "author" : "BlackIronSpectre",
    "comment" : "You're a bloody traitor you kilt sniffing cunt!",
    "comment_2grams" : "you're-a a-bloody bloody-traitor traitor-you you-kilt kilt-sniffing sniffing-cunt!",
    "comment_has_upper_case_word" : false,
    "comment_whitespace" : "You're a bloody traitor you kilt sniffing cunt!",
    "date" : "2016-09",
    "downs" : 0,
    "label" : 1,
    "parent_comment" : "English here.. bloody love Irn Bru. But then again.. I love Scotland and everything about it. I think I should have been born Scottish.",
    "score" : 90,
    "subreddit" : "AskReddit",
    "ups" : 90
  } ]
}
```

### 4. Predict if "wow you are smart" comment is sarcastic or not

No hint.

**The repsonse you should see**

```js
{
  "offset" : 0,
  "total" : 2,
  "hits" : [ {
    "$p" : 0.9309766190277114,
    "field" : "label",
    "feature" : 1
  }, {
    "$p" : 0.06902338097228855,
    "field" : "label",
    "feature" : 0
  } ]
}
```

The probability of the text being sarcastic is 93.1% based on Aito's prediction.


### 5. Explain the results of the last prediction

Hint: select \$why to get statistical information about predictions.

**The repsonse you should see**

```js
{
  "offset" : 0,
  "total" : 2,
  "hits" : [ {
    "$why" : {
      "type" : "product",
      "factors" : [ {
        "type" : "baseP",
        "value" : 0.5
      }, {
        "type" : "normalizer",
        "name" : "exclusiveness",
        "value" : 1.0
      }, {
        "type" : "relatedVariableLift",
        "variable" : "comment:wow",
        "value" : 1.6189729371414923
      }, {
        "type" : "relatedVariableLift",
        "variable" : "comment:smart",
        "value" : 1.520886821001524
      } ]
    }
  },
  ...
```

Comments which have the word "wow" in them are 1.6x more likely to be
sarcastic than an average comment.


### 6. Evaluate how accurately Aito could predict if a comment is sarcastic based on just the comment

Hint: the goal is to use 90% of the data in Aito for training and 10% for testing the accuracy.
The 10% of data will be tested as if Aito didn't know if the comments are sarcastic or not. See
Evaluate in API docs.

**The repsonse you should see**

```js
{
  "mxe" : 0.9271739795298308,
  "baseAccuracy" : 0.5,
  "meanUs" : 11184.48125,
  "accuracyGain" : 0.12,
  "n" : 1000,
  "rankGain" : 0.12,
  "warmingMs" : 0.0,
  "features" : 119133.0,
  "accuracy" : 0.62,
  "trainSamples" : 9000.0,
  "geomMeanP" : 0.5258874672093419,
  "baseGmp" : 0.5,
  "meanMs" : 11.18448125,
  "error" : 0.38,
  "baseError" : 0.5,
  "testSamples" : 1000,
  "geomMeanLift" : 1.0517749344186837,
  "meanRank" : 0.38,
  "meanNs" : 1.118448125E7,
  "h" : 1.0,
  "informationGain" : 0.07282602047016917,
  "baseMeanRank" : 0.5
}
```

Here the correct field is `accuracy`.


### 7. Explain what features make comments sarcastic

Hint: see Relate query in API docs.


**The repsonse you should see**

```js
{
  "offset" : 0,
  "total" : 99,
  "hits" : [ {

    ...

    {
      "related" : "label:1",
      "lift" : 1.5481235278381007,
      "condition" : "comment:yeah",
      "fs" : {
        "f" : 5000,
        "fOnCondition" : 275,
        "fOnNotCondition" : 4725,
        "fCondition" : 354,
        "n" : 10000
      },
      "ps" : {
        "p" : 0.5,
        "pOnCondition" : 0.7740617639190503,
        "pOnNotCondition" : 0.4899421867374226,
        "pCondition" : 0.035399930417845726
      },
      "info" : {
        "h" : 1.0,
        "mi" : 0.22913674121873823,
        "miTrue" : 0.4880618812947286,
        "miFalse" : -0.2589251400759904
      },
      "relation" : {
        "n" : 10000,
        "varFs" : [ 354, 5000 ],
        "stateFs" : [ 4921, 79, 4725, 275 ],
        "mi" : 0.008392996906335543
      }
    },
    ...
```

Results are sorted by default on how strong the corrrelation is, most correlating ones being first.
Comments which have the word "yeah" in them are 1.5x more likely to be sarcastic than an average
comment.

## Initial Aito setup

This can be used as a guide to upload this same dataset into your own environment.

### Full speed

Warning: this deletes all data in the aito environment.

- Set `API_KEY` environment variable
- Change `AITO_ENV` in upload.sh
- `npm install` for transform.js
- Run `bash upload.sh`

### Steps explained

- Download the [Sarcasm on Reddit](https://www.kaggle.com/danofer/sarcasm) dataset.
- Unzip the package. We'll be using train-balanced-sarcasm.csv file.
- Cut the data size

  The balanced data set contains 50% sarcastic and 50% not sarcastic comments. We want to maintain this balance.

  Doing a simple `head -n 10001 train-balanced-sarcasm.csv > train-balanced-sarcasm-small.csv` results
  into a wrong balance: 3710 sacrastic comments out of 10 000.

  The csv fortunately has the label information as the first character on each line, so we
  can split it based on that:

  ```
  head -n 1 train-balanced-sarcasm.csv > train-balanced-sarcasm-small.csv

  grep -i "^0" train-balanced-sarcasm.csv | head -n 5000 >> train-balanced-sarcasm-small.csv
  grep -i "^1" train-balanced-sarcasm.csv | head -n 5000 >> train-balanced-sarcasm-small.csv
  ```

- With [csvtojson](https://www.npmjs.com/package/csvtojson), run `csvtojson train-balanced-sarcasm-small.csv > comments.json`

  You could auto-convert types with `csvtojson --checkType=true train-balanced-sarcasm-small.csv > comments.json`, but in this case it didn't work properly.
  Textual comments which are numbers will be also converted and then they don't comply with the
  schema.

- With [jq](https://stedolan.github.io/jq/), convert numbers to correct types and also JSON to NDJSON

  ```
  jq -c '.[] | . + {label: (.label)|tonumber, score: (.score)|tonumber, ups: (.ups)|tonumber, downs: (.downs)|tonumber}' comments.json > comments.ndjson
  ```

  Breaking it down:

  - `-c` compressed (remove extra spaces)
  - `.[]` Iterates the JSON array and passes each object through the pipe (this will in the end cause json->ndjson conversion)
  - `|` is similar to a shell piping
  - `. +` . refers to the individual object and with + we extend it
  - `{label: (.label)|tonumber, score: (.score)|tonumber, ups: (.ups)|tonumber, downs: (.downs)|tonumber}'` the new object that will override the string values with numerical ones

- Enrich the data with transform.js

  - Add 2-grams of the comment
  - Duplicate comment to a comment_whitespace so we can try Whitespace analyzer instead of English. Whitespace analyzer preserves for example capital letters.
  - Add comment_has_upper_case_word boolean as an example

- Create the schema to the environment

  Add `export API_KEY=READ_WRITE_KEY` to `.env` file.

  ```bash
  source .env

  curl -X DELETE \
    https://aito-reddit-sarcasm.api.aito.ai/api/v1/schema \
    -H "x-api-key: $API_KEY"

  curl -X PUT \
    https://aito-reddit-sarcasm.api.aito.ai/api/v1/schema \
    -H "content-type: application/json" \
    -H "x-api-key: $API_KEY" \
    -d@schema.json
  ```

- With [upload-file.sh](https://github.com/AitoDotAI/aito-tools) we're uploading comments.json to the environment

  Make sure `API_KEY` environment variable is set, upload-file.sh uses that.

  ```bash
  bash upload-file.sh comments.ndjson https://aito-reddit-sarcasm.api.aito.ai
  ```

- Now the data should be uploaded!
