gulp = require "gulp"
rs   = require "run-sequence"

clean  = require "gulp-clean"
coffee = require "gulp-coffee"
concat = require "gulp-concat"
jade   = require "gulp-jade"
serve  = require "gulp-serve"
stylus = require "gulp-stylus"

gulp.task "clean", ->
  gulp.src "temp", read: false
      .pipe clean()

gulp.task "stylus", ->
  gulp.src "app/styles/app.styl"
      .pipe stylus
        compress: true
      .pipe gulp.dest "temp/styles"

gulp.task "jade", ->
  gulp.src "app/index.jade"
      .pipe jade()
      .pipe gulp.dest "temp/"

  gulp.src "app/scripts/**/*.jade"
      .pipe jade()
      .pipe gulp.dest "temp/"

gulp.task "coffee", ->
  gulp.src [
    "app/scripts/app.coffee"
    "app/scripts/components/**/*.coffee"
    "app/scripts/routes.coffee"
    "app/scripts/bootstrap.coffee"
  ]
  .pipe coffee()
  .pipe concat "app.js"
  .pipe gulp.dest "temp/"

gulp.task "watch", ->
  gulp.watch "app/**/*", { read: false }, [ "build" ]

gulp.task "serve", serve
  root: [ "temp" ]
  port: 9000

gulp.task "default", [
  "serve"
  "watch"
  "build"
]

gulp.task "build", ->
  rs  "clean", [
  "stylus"
  "jade"
  "coffee"
  ]
