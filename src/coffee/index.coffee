#require 'angular'
#require 'parse'

APPLICATION_ID = 'BLQE6s5hCJf6HZSaeXB6e1EVXwi7fDyPHAdoRwGn'
JAVASCRIPT_KEY = 'RL2PReLPl4OzzW7sFaAKDW35y1GfxyreRKwZnovd'

Parse.initialize APPLICATION_ID, JAVASCRIPT_KEY

angular.module 'app', []
.controller 'MeetupController', require './ng/controller/MeetupController'
.controller 'MentorController', require './ng/controller/MentorController'
