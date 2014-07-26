Meetup = require '../../parse/class/Meetup'

module.exports = ($scope, $http) ->
  $scope.upcomings = []
  new Parse.Query Meetup
  .greaterThan 'start_time', new Date()
  .ascending 'start_time'
  .find()
  .then (result) ->
    $scope.upcomings =
      row.attributes for row in result
    $scope.$apply()
