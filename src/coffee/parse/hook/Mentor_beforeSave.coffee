Mentor = require 'cloud/class/Mentor'

module.exports = (request, response) ->
  source = request.object.get 'source'
  
  unless request.object.isNew()
    response.success()
    return
  unless source
    response.error 'A Mentor must have a source (user_id).'
    return
  new Parse.Query Mentor
  .equalTo 'source', source
  .first()
  .then (result) ->
    if result
      response.error "A Mentor (#{result.get 'source'}) already exists."
    else
      response.success()
  , (error) ->
      response.error 'Could not validate uniqueness for this Mentor object.'
