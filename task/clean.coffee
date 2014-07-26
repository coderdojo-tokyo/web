gulp = require 'gulp'
del  = require 'del'

DIST1 = './public'
DIST2 = './cloud'

gulp.task 'clean', (cb) ->
  del [DIST1, DIST2], -> cb()
