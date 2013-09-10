james  = require 'james'
jade   = require 'james-jade-static'
stylus = require 'james-stylus'
uglify = require 'james-uglify'

shim       = require 'browserify-shim'
browserify = require 'browserify'
coffeeify  = require 'coffeeify'

transmogrifyCoffee = (debug) ->
  libs =
    jquery:
      path: './client/js/vendor/jquery/jquery.js'
      exports: '$'

  bundle = james.read shim(browserify(), libs)
    .transform(coffeeify)
    .require(require.resolve('./client/js/main.coffee'), entry: true)
    .bundle
      debug: debug

  bundle = bundle.transform(uglify) unless debug
  bundle.write('public/js/bundle.js')

transmogrifyJade = (file) ->
  james.read(file)
    .transform(jade)
    .write(file
      .replace('client', 'public')
      .replace('.jade', '.html'))


transmogrifyStylus = (file) ->
  james.read(file)
    .transform(stylus)
    .write(file
      .replace('client', 'public')
      .replace('.stylus', '.css')
      .replace('.styl', '.css'))

james.task 'browserify', -> transmogrifyCoffee false
james.task 'browserify_debug', -> transmogrifyCoffee true

james.task 'jade_static', ->
  james.list('client/**/*.jade').forEach transmogrifyJade

james.task 'stylus', ->
  james.list('client/**/*.styl').forEach transmogrifyStylus

james.task 'actual_watch', ->
  james.watch 'client/**/*.coffee', -> transmogrifyCoffee true
  james.watch 'client/**/*.jade', (ev, file) -> transmogrifyJade file
  james.watch 'client/**/*.styl', (ev, file) -> transmogrifyStylus file

james.task 'server', =>
  require('./server/server.coffee')

james.task 'reload', =>
  reload = require('james-reload')
    proxy: 9001
    reload: 9002
  james.watch 'public/**/*.js', -> reload()
  james.watch 'public/**/*.css', -> reload(true)
  james.watch 'public/**/*.html', -> reload()

james.task 'build_debug', ['browserify_debug', 'jade_static', 'stylus']
james.task 'build', ['browserify', 'jade_static', 'stylus']
james.task 'watch', ['build_debug', 'actual_watch']
james.task 'default', ['build_debug']
james.task 'httpd', ['server', 'reload']

