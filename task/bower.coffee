gulp        = require 'gulp'
rename      = require 'gulp-rename'
bower       = require 'bower'
runSequence = require 'run-sequence'
merge       = require 'merge-stream'

SRC  = './bower_components'
DIST = './public/js'

gulp.task 'bower', -> runSequence 'bower-update', 'bower-copy'

gulp.task 'bower-install', -> bower.commands.install()
  
gulp.task 'bower-update', -> bower.commands.update()
  
gulp.task 'bower-copy', ->
  merge(
    gulp.src "#{SRC}/parse/index.js"
    .pipe rename basename: 'parse'
    gulp.src "#{SRC}/angular/angular.min.js"
  )
  .pipe gulp.dest "#{DIST}/"
