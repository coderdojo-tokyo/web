gulp        = require 'gulp'

SRC  = './src'
DIST = './public'
  
gulp.task 'image', ->
  gulp.src "#{SRC}/og-image.png"
  .pipe gulp.dest "#{DIST}/"
