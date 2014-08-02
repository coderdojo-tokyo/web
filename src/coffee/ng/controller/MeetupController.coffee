Meetup = require '../../parse/class/Meetup'

module.exports = ($scope, $http) ->
  $scope.loaded = false
  $scope.upcomings = []
  yesterday = new Date().setDate new Date().getDate() - 1
  new Parse.Query Meetup
  .greaterThan 'start_time', yesterday
  .ascending 'start_time'
  .find()
  .then (result) ->
    $scope.upcomings =
      row.attributes for row in result
    $scope.loaded = true
    $scope.$apply()
