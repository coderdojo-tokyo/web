gulp    = require 'gulp'
changed = require 'gulp-changed'
replace = require 'gulp-replace'

SRC  = './src'
DIST = './public'

gulp.task 'html', ->
  gulp.src ["#{SRC}/index.html"]
  .pipe changed "#{DIST}/"
  .pipe replace ".#{DIST}/js/", 'js/'
  .pipe gulp.dest "#{DIST}/"
