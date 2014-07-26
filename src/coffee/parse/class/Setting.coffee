module.exports = Parse.Object.extend 'Setting',
  val: -> @get 'value'
,
  cache: {}
  cached: false
  load: ->
    promise = new Parse.Promise()
    new Parse.Query 'Setting'
    .find()
    .then (results) =>
      @cache[row.get 'key'] = row for row in results
      cached = true
      promise.resolve()
    promise
  get: (key) -> @cache[key]?.val()