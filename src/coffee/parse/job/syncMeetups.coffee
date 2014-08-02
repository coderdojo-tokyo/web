FB = require 'cloud/lib/facebook'
Meetup = require 'cloud/class/Meetup'
Mentor = require 'cloud/class/Mentor'

module.exports = (request, status) ->
  Parse.Cloud.useMasterKey()
  mentors = {}

  loadMentors = () ->
    # メンターリストをDBから取得
    new Parse.Query Mentor
    .find()
    .then (result) ->
      mentors[row.get 'source'] = row for row in result
  
  saveMeetup = (fb_event) ->
    next_week = new Date().setDate new Date().getDate() + 7
    event_date = new Date fb_event.start_time
    tags = []
    
    # 参加メンターのリスト
    attending =
      for row in fb_event.attending?.data || [] when mentors[row.id]?
        # メンター(Mentor)の最終参加日を更新
        if next_week > event_date > (mentors[row.id].get('last_attended') || 0)
          mentors[row.id].set 'last_attended', event_date
        # メンターのタグを収集
        tags = tags.concat mentors[row.id].get 'tags'
        row.id
      
    # タグの重複除去
    tags = tags.filter (e, i, arr) -> i == arr.lastIndexOf e
  
    # イベント(Meetup)を登録または更新
    new Parse.Query Meetup
    .equalTo 'source', fb_event.id
    .first()
    .then (meetup) ->
      (meetup || new Meetup())
      .setValues fb_event
      .set 'mentors', attending
      .set 'tags', tags
      .save()
  
  loadMentors()
  .then ->
    FB.api 'coderdojo.tokyo',
      locale: 'ja_JP'
      fields: 'events.fields(id,name,location,venue,description,start_time,end_time,attending,cover)'
  .then (data) ->
    promises = for fb_event in data.events.data
      saveMeetup fb_event
    Parse.Promise.when promises
  .then ->
    promises = for id, mentor of mentors
      mentor.save()
    Parse.Promise.when promises
  .then ->
    status.success 'Fetched successfully.'
