Mentor = require '../../parse/class/Mentor'

module.exports = ($scope, $http) ->
  $scope.loaded = false
  $scope.mentors = []
  new Parse.Query Mentor
  .descending 'last_attended'
  .find()
  .then (result) ->
    $scope.mentors =
      row.attributes for row in result
    $scope.loaded = true
    $scope.$apply()
