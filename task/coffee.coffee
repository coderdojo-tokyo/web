gulp       = require 'gulp'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
streamify  = require 'gulp-streamify'
uglify     = require 'gulp-uglify'

SRC  = './src/coffee'
DIST = './public/js'

gulp.task 'coffee', ->
  browserify
    entries: ["#{SRC}/index.coffee"]
    extensions: ['.coffee']
  .bundle()
  .pipe source 'index.js'
  .pipe streamify uglify mangle: false# without mangling for AngularJS
  .pipe gulp.dest "#{DIST}/"