$ = require 'jquery'

ContentHeader = require '../../lib/scripts/views/content_header'

describe "ContentHeader", ->
  beforeEach ->
    @app.lessons.first().select()
    @view = new ContentHeader({ @app, el: document.body }).render()
    jasmine.clock().install()

  afterEach ->
    @view.remove()
    jasmine.clock().uninstall()

  describe 'bindings', ->
    describe 'when the header is first rendered', ->
      it 'displays the currently shown lesson number', ->
        @view.ui.number.each ->
          expect($ @).toHaveText '1'

    describe 'when a new lesson is selected', ->
      beforeEach ->
        @app.lessons.at(1).select()
        jasmine.clock().tick 251

      it 'updates the lesson number', ->
        @view.ui.number.each ->
          expect($ @).toHaveText '2'

  describe 'clicking the menu toggle', ->
    it 'toggles the sidebar visibility', ->
      visibility = @app.state.get 'sidebarVisible'
      @view.ui.toggleSidebar.click()
      expect(@app.state.get 'sidebarVisible').toEqual !visibility
