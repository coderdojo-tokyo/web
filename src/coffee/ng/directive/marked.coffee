marked = require 'marked'

module.exports = ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.html marked element.text()