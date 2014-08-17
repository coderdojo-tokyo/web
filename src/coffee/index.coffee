config = require '../../config/front'

Parse.initialize config.parse.applicationId, config.parse.javascriptKey

angular.module 'app', []
.controller 'MeetupController', require './ng/controller/MeetupController'
.controller 'MentorController', require './ng/controller/MentorController'
