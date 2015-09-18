$ = require 'jquery'

PreviousPageLink = require '../../lib/scripts/views/previous_page_link'

describe "PreviousPageLink", ->
  beforeEach ->
    @view = new PreviousPageLink({ @app, el: document.body }).render()
    @view.onRender()
    @view.setModel = (model) -> @model = model

  afterEach ->
    @view.remove()

  describe "bindings", ->
    beforeEach ->
      @app.lessons.at(1).select()

    it "disables if no next (or previous)", ->
      expect(@view.$el).not.toHaveClass('disabled')
      @view.setModel = (model) -> @model = undefined
      @app.lessons.at(2).select()

      expect(@view.$el).toHaveClass('disabled')

  describe "pagination", ->
    beforeEach ->
      @app.lessons.at(1).select()
      spyOn(@app.lessons, 'selectById').and.callThrough()
      jasmine.clock().install()

    afterEach ->
      jasmine.clock().uninstall()

    it "updates selected id", ->
      @view.ui.pageAction.click()
      jasmine.clock().tick 501
      expect(@app.lessons.selectById).toHaveBeenCalledWith @app.lessons.at(1).id

    it "does not update if button is disabled", ->
      @view.$el.addClass('disabled')
      @view.ui.pageAction.click()
      jasmine.clock().tick 501
      expect(@app.lessons.selectById).not.toHaveBeenCalled()
