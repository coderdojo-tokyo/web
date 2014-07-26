gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
changed = require 'gulp-changed'

SRC  = './src/coffee/parse'
DIST = './cloud'
    
gulp.task 'parse', ->
  gulp.src ["#{SRC}/**/*.coffee"]
  .pipe changed "#{DIST}/"
  .pipe coffee bare: true
  .pipe gulp.dest "#{DIST}/"
