compress = require 'compression'
express  = require 'express'

{ course, lessons } = require './assets/data'

app = express()

if app.get('env') is 'development'
  browserSync = require 'browser-sync'
  bs = browserSync
    files:          ['demo/**/*', 'dist/**/*']
    logSnippet:     false
    port:           5555
    reloadDelay:    1000
    reloadDebounce: 1000
  app.use require('connect-browser-sync')(bs)

app.set 'views', 'demo/views'
app.set 'view engine', 'jade'

renderCourse = (req, res, next) ->
  res.render 'index', data: { course, lessons }, lessonId: req.params.id

app.get '/', renderCourse
app.get '/lessons/:id', renderCourse

app.put '/courses/:courseId/completion', (req, res, next) ->
  res.sendStatus 204

app.use compress()
app.use express.static 'dist'
app.use express.static 'node_modules'

app.start = ->
  app.listen 3030, ->
    console.log 'Web server listening at port: 3030'

app.start() if require.main is module
