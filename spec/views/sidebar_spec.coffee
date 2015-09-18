$ = require 'jquery'

Sidebar  = require '../../lib/scripts/views/sidebar'

describe 'Sidebar', ->
  beforeEach ->
    @app.state.set sidebarVisible: true
    @view = new Sidebar({ @app, el: document.body }).render()

  afterEach ->
    @view.remove()

  describe 'toggle', ->
    beforeEach ->
      expect($ @app.el).not.toHaveClass 'sidebar--hidden'

    it 'slides the sidebar out on state change', ->
      @app.state.toggleSidebar()
      expect($ @app.el).toHaveClass 'sidebar--hidden'
