Backbone = require 'backbone'

class App
  constructor: ({ @el, data, @root, @lessonId }) ->
    console.log data

  start: ->
    console.log 'start me'

  stop: ->
    @router.layout?.remove()
    Backbone.history.stop()
    Backbone.history.handlers = []


module.exports = App
