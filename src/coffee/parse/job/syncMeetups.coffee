FB = require 'cloud/lib/facebook'
Meetup = require 'cloud/class/Meetup'

# 新着のイベントを確認
checkNewEvents = ->
  FB.api 'coderdojo.tokyo/events'
  .then (result) ->
    promises = for row in result.data
      do ->
        promise = new Parse.Promise()
        new Meetup
          source: row.id
          name: row.name
          start_time: row.start_time
        .save()
        .done -> promise.resolve()
        .fail -> promise.resolve() # 保存に失敗した場合も処理を続行
        promise
    Parse.Promise.when promises

# イベントの詳細情報を取得
fetchDetail = (id) ->
  new Parse.Query Meetup
  .get id
  .then (meetup) ->
    event_id = meetup.get 'source'
    FB.api event_id, locale: 'ja_JP'
    .then (data) ->
      meetup
      .setValues data
      .save()

module.exports = (request, status) ->
  Parse.Cloud.useMasterKey()
  
  checkNewEvents()
  .then ->
    new Parse.Query Meetup
    .descending 'start_time'
    .limit 10
    .find()
  .then (result) ->
    promises = for row in result
      fetchDetail row.id
    Parse.Promise.when promises
  .then ->
    status.success 'Fetched successfully.'
