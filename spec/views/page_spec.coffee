Page     = require '../../lib/scripts/models/page'
Pages    = require '../../lib/scripts/collections/pages'
PageView = require '../../lib/scripts/views/page'

describe 'Page view', ->
  beforeEach ->
    @model = new Page @app.lessons.first().attributes
    @pages = new Pages [@model]
    @view  = new PageView({ @model, @app, el: document.body }).render()

  afterEach ->
    @view.remove()

  describe 'when the page is removed', ->
    beforeEach ->
      @view.runtime = jasmine.createSpyObj 'Runtime', ['start', 'stop']
      @pages.remove @model

    it 'stops the runtime', ->
      expect(@view.runtime.stop).toHaveBeenCalled()

  describe 'when the page is transitioned', ->
    describe 'to previous', ->
      beforeEach ->
        @model.set transition: 'previous'

      it 'adds the correct transition class', ->
        expect(@view.$el).toHaveClass 'transition--previous'
        expect(@view.$el).not.toHaveClass 'transition--next'

    describe 'to current', ->
      beforeEach ->
        @model.set transition: 'current'

      it 'removes all the transition classes', ->
        expect(@view.$el).not.toHaveClass 'transition--previous'
        expect(@view.$el).not.toHaveClass 'transition--next'

    describe 'to next', ->
      beforeEach ->
        @model.set transition: 'next'

      it 'adds the correct transition class', ->
        expect(@view.$el).not.toHaveClass 'transition--previous'
        expect(@view.$el).toHaveClass 'transition--next'
