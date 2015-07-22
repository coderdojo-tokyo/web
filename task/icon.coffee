gulp        = require 'gulp'
rename      = require 'gulp-rename'
sketch      = require 'gulp-sketch'
iconfont    = require 'gulp-iconfont'
consolidate = require 'gulp-consolidate'
merge       = require 'merge-stream'

SRC      = './src/icon'
DIST     = './public/font'
FONTNAME = 'coderdojo' # set name of your symbol font
TEMPLATE = 'fontawesome-style' # you can also choose 'foundation-style'

gulp.task 'icon', ->
  gulp.src "#{SRC}/symbol-font-16px.sketch" # you can also choose "symbol-font-16px.sketch"
    .pipe sketch
      export: 'artboards'
      formats: 'svg'
    .pipe iconfont fontName: FONTNAME
    .on 'glyphs', (glyphs) ->
      options =
        glyphs: glyphs.map (glyph) ->
          # this line is needed because gulp-iconfont has changed the api from 2.0
          name: glyph.name
          codepoint: glyph.unicode[0].charCodeAt 0
        fontName: FONTNAME
        fontPath: './' # set path to font (from your CSS file if relative)
        className: 'cd' # set class name in your CSS
      merge (
        gulp.src "#{SRC}/#{TEMPLATE}.css"
          .pipe consolidate 'lodash', options
          .pipe rename basename: FONTNAME
          .pipe gulp.dest "#{DIST}/"
        gulp.src "#{SRC}/#{TEMPLATE}.html"
          .pipe consolidate 'lodash', options
          .pipe rename basename:'sample'
          .pipe gulp.dest "#{DIST}/"
      )
    .pipe gulp.dest "#{DIST}/" # set path to export your fonts
