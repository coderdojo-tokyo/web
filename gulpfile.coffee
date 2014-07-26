gulp        = require 'gulp'
runSequence = require 'run-sequence'
requireDir  = require 'require-dir'
dir         = requireDir './task'
{exec}      = require 'child_process'
browserSync = require 'browser-sync'
reload      = browserSync.reload

gulp.task 'install', -> runSequence 'clean', 'bower', 'icon', ['parse', 'html', 'coffee', 'css']

gulp.task 'deploy', (cb) ->
  exec 'parse deploy', (error, stdout) ->
    console.log stdout
    cb()

gulp.task 'watch', ->
  browserSync.init
    notify: false
    server: baseDir: './public/'
  o = debounceDelay: 10000
  gulp.watch [
    './src/coffee/*.coffee'
    './src/coffee/ng/**/*.coffee'
    './src/coffee/parse/class/*.coffee'
  ], o, ['coffee']
  gulp.watch ['./src/coffee/parse/**/*.coffee'], o, ['parse']
  gulp.watch ['./src/css/**/*.css'], o, ['css']
  gulp.watch ['./src/icon/*.sketch/Data'], o, ['icon']
  gulp.watch ['./src/index.html'], o, ['html']
  gulp.watch ['./public/css/style.css', './public/index.html', './public/markdown/*.md'], o, reload
