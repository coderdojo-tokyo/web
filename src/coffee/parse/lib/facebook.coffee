Setting = require 'cloud/class/Setting'

module.exports = 
  api: (path, options = {}, cb) ->
    promise = new Parse.Promise()
    Setting.load()
    .then ->
      id = Setting.get 'facebook_app_id'
      secret = Setting.get 'facebook_app_secret'
      options.access_token = "#{id}|#{secret}"
      Parse.Cloud.httpRequest
        url: "https://graph.facebook.com/#{path}"
        params: options
    .then (httpResponse) ->
      ret = httpResponse.data || httpResponse
      promise.resolve ret
      cb ret if cb
    promise