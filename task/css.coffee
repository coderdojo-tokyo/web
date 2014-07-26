gulp         = require 'gulp'
cssimport    = require 'gulp-cssimport'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
replace      = require 'gulp-replace'
csslint      = require 'gulp-csslint'
notify       = require 'gulp-notify'

SRC  = './src/css'
DIST = './public/css'

gulp.task 'css', ->
  gulp.src ["#{SRC}/style.css"]
  .pipe cssimport()
  .pipe autoprefixer 'last 2 versions'
  .pipe replace "url('./coderdojo", "url('../font/coderdojo"
  .pipe minifyCss keepSpecialComments: 0
  .pipe gulp.dest "#{DIST}/"

gulp.task 'css-lint', ->
  gulp.src ["#{SRC}/**/*.css"]
  .pipe csslint()
  .pipe csslint.reporter()
  .pipe notify (file) -> "#{file.relative} (#{file.csslint.results.length} errors)" unless file.csslint.success  
