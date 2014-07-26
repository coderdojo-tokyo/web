Meetup = require 'cloud/class/Meetup'

module.exports = (request, response) ->
  source = request.object.get 'source'
  
  unless request.object.isNew()
    response.success()
    return
  unless source
    response.error 'A Meetup must have a source (event_id).'
    return
  new Parse.Query Meetup
  .equalTo 'source', source
  .first()
  .then (result) ->
    if result
      response.error "A Meetup (#{result.get 'source'}) already exists."
    else
      response.success()
  , (error) ->
      response.error 'Could not validate uniqueness for this Meetup object.'