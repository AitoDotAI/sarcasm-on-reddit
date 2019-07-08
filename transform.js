const _ = require('lodash')
const split2 = require('split2')

function ngramify(str, n) {
  const words = str.split(' ')
  return words
    .slice(0, 1 - n)
    .map((_, i) => words.slice(i, i + n))
}

function isUpperCase(str) {
  return str === str.toUpperCase()
}

function main() {
  process.stdin.resume()
  process.stdin.setEncoding('utf8')

  process.stdin
    .pipe(split2(JSON.parse))
    .on('data', (obj) => {
      const commentWords = obj.comment.split(' ')
      const ngram2 = ngramify(obj.comment, 2)
      const pairsForAito = _.map(ngram2, (pair) => {
        return pair.join('-').toLowerCase()
      }).join(' ')

      const hasUpperCaseWord = _.some(commentWords, isUpperCase)
      const newObj = _.merge({}, obj, {
        comment_2grams: pairsForAito,
        comment_whitespace: obj.comment,
        comment_has_upper_case_word: hasUpperCaseWord,
      })

      console.log(JSON.stringify(newObj))
    })
}

main()
