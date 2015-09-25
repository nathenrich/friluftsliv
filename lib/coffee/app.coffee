$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
React = require 'react'

class App
  constructor: ({ @el, data, @root, @lessonId }) ->
    console.log data

  start: ->
    console.log 'start me'
    
    
    {div} = React.DOM

    Hello = React.createClass
      render: ->
        (div {}, ['Hello ' + @props.name])

    #React.renderComponent (Hello {name: 'World'}), document.body
    #React.render 'Hello', window.document.getElementById('mount-point')
    

  stop: ->
    @router.layout?.remove()
    Backbone.history.stop()
    Backbone.history.handlers = []


module.exports = App
