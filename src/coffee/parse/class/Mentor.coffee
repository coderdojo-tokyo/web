module.exports = Parse.Object.extend 'Mentor',
  initialize: (attrs) ->
    @setValues attrs if attrs
    @
  setValues: (attrs) ->
    @set 'source', attrs.source || attrs.id if attrs.source? || attrs.id?
    @set 'last_name', attrs.last_name if attrs.last_name?
    @set 'first_name', attrs.first_name if attrs.first_name?
    @set 'description', attrs.description if attrs.description?
    if attrs.last_attended?
      if typeof attrs.last_attended == 'string'
        @set 'last_attended', new Date attrs.last_attended
      else
        @set 'last_attended', attrs.last_attended
    @
