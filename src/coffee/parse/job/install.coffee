Setting = require 'cloud/class/Setting'
Meetup = require 'cloud/class/Meetup'
Mentor = require 'cloud/class/Mentor'

module.exports = (request, status) ->
  Parse.Cloud.useMasterKey()
  
  new Setting()
  .set 'key', 'facebook_app_id'
  .set 'value', 'replace_me'
  .save()
  .then ->
    new Setting()
    .set 'key', 'facebook_app_secret'
    .set 'value', 'replace_me'
    .save()
  .then ->
    new Mentor()
    .setValues
      source: '1394372839'
      last_name: '山田'
      first_name: '太郎'
      description: 'ここにメンターの紹介文 (50字程度)'
      last_attended: {}
      tags: [
        'HTML'
        'JavaScript'
        'CSS'
      ]
      url: 'https://github.com/cognitom'
    .save()
  .then ->
    status.success 'Fetched successfully.'