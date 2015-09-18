_              = require 'underscore'
ContentActions = require '../../lib/scripts/views/content_actions'

describe "ContentActions", ->
  beforeEach ->
    @app.completion.get('lessons').first().set completed: false
    @app.lessons.first().select()
    @view = new ContentActions({ @app, el: document.body }).render()
    @view.onRender()
    jasmine.clock().install()

  afterEach ->
    @view.remove()
    jasmine.clock().uninstall()

  describe 'bindings', ->
    describe 'when the header is first rendered', ->
      it 'shows the completion state of the current lesson', ->
        expect(@view.ui.markLearnedText).toHaveText 'Mark as Learned'
        expect(@view.ui.markLearned).toHaveClass 'btn__flat--green'
        expect(@view.ui.markLearned).not.toHaveClass 'btn__flat--greenBackground'

    describe 'when a new lesson is selected', ->
      beforeEach ->
        @app.completion.get('lessons').at(1).set completed: true
        @app.lessons.at(1).select()
        jasmine.clock().tick 251

      it 'updates the learned button state', ->
        expect(@view.ui.markLearnedText).toHaveText 'Learned'
        expect(@view.ui.markLearned).toHaveClass 'btn__flat--greenBackground'
        expect(@view.ui.markLearned).not.toHaveClass 'btn__flat--green'

    describe 'when the current lesson is completed', ->
      beforeEach ->
        @view.status.set completed: true

      it 'updates the learned button state', ->
        expect(@view.ui.markLearnedText).toHaveText 'Learned'
        expect(@view.ui.markLearned).toHaveClass 'btn__flat--greenBackground'
        expect(@view.ui.markLearned).not.toHaveClass 'btn__flat--green'

    describe 'when the lesson is not learnable (ie: quiz)', ->
      beforeEach ->
        # need to reset the content attribute with a new object
        # for the change:content event to fire
        content = _.clone @view.model.get('content')
        content.type = 'Quiz'
        @view.model.set('content', content)

      it 'hides the markLearned button', ->
        expect(@view.$el).toHaveClass 'unlearnable'

  describe 'clicking the "Mark as Learned" button', ->
    beforeEach ->
      spyOn @app.completion, 'toggleCompleted'
      @view.ui.markLearned.click()

    it 'toggle completed on the current lesson', ->
      expect(@app.completion.toggleCompleted).toHaveBeenCalled()

  describe 'clicking the lesson resources opens dropdown', ->
    beforeEach ->
      @view.ui.dropdownOpen.click()

    it 'toggles the class of "open"', ->
      expect(@view.ui.externalResources).toHaveClass 'open'
