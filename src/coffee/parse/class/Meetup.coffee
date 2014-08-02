module.exports = Parse.Object.extend 'Meetup',
  initialize: (attrs) ->
    @setValues attrs if attrs
    @
  setValues: (attrs) ->
    @set 'source', attrs.source || attrs.id if attrs.source? || attrs.id?
    @set 'name', attrs.name if attrs.name?
    @set 'location', attrs.location if attrs.location?
    @set 'venue_id', attrs.venue?.id || attrs.venue_id if attrs.venue?.id || attrs.venue_id
    @set 'description', attrs.description if attrs.description?
    if attrs.start_time?
      if typeof attrs.start_time == 'string'
        @set 'start_time', new Date attrs.start_time
      else
        @set 'start_time', attrs.start_time
    if attrs.end_time?
      if typeof attrs.end_time == 'string'
        @set 'end_time', new Date attrs.end_time
      else
        @set 'end_time', attrs.end_time
    @set 'cover_source', attrs.cover.source if attrs.cover?.source?
    @
