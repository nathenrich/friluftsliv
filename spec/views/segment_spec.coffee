config = require '../../lib/scripts/config'
Segment = require '../../lib/scripts/views/segment'

describe 'Segment', ->
  beforeEach ->
    @model = @app.lessons.first()
    @completion = @app.completion.get('lessons').get @model
    @view = new Segment({ @model, @app, el: document.body }).render()

  afterEach ->
    @view.remove()

  describe "selected lesson change", ->
    it "highlights when selected", ->
      @model.set('selected', true)
      expect(@view.$el).toHaveClass('courseList__lesson--selected')

    it "removes highlight when not selected", ->
      @model.set('selected', false)
      expect(@view.$el).not.toHaveClass('courseList__lesson--selected')

  describe "lesson complete state", ->
    it "can mark completed", ->
      @completion.set('completed', true)
      expect(@view.$el).toHaveClass('courseList__lesson--completed')

    it "can mark not completed", ->
      @completion.set('completed', false)
      expect(@view.$el).not.toHaveClass('courseList__lesson--completed')

  describe "lesson selection", ->
    beforeEach ->
      spyOn(@model, 'select')
      @view.$el.click()

    it "triggers select on the model", ->
      expect(@model.select).toHaveBeenCalled()

  describe 'window size', ->
    beforeEach ->
      spyOn @app.state, 'toggleSidebar'

    describe '< large breakpoint', ->
      beforeEach ->
        window.innerWidth = config.breakpoints.lg - 1

      it 'selecting a lesson closes the sidebar', ->
        @view.$el.click()
        expect(@app.state.toggleSidebar).toHaveBeenCalled()

    describe '>= large breakpoint', ->
      beforeEach ->
        window.innerWidth = config.breakpoints.lg

      it 'selecting a lesson does not close the sidebar', ->
        @view.$el.click()
        expect(@app.state.toggleSidebar).not.toHaveBeenCalled()
