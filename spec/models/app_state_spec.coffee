$ = require 'jquery'

describe 'AppState model', ->
  beforeEach ->
    { @state } = @app
    @state.set 'sidebarVisible', undefined

  describe "defaults", ->
    beforeEach ->
      $.removeCookie 'lessonSidebarVisible'
      @state._restoreSavedSidebarState()

    it "allows undefined to pass thru", ->
      expect(@state.get('sidebarVisible')).toBeUndefined()

    it "has overview visible as true", ->
      expect(@state.get('overviewVisible')).toEqual true

  describe "restores values from cookies", ->
    beforeEach ->
      $.cookie 'lessonSidebarVisible', 'false'
      @state._restoreSavedSidebarState()

    it "sets sidebarVisible to false", ->
      expect(@state.get('sidebarVisible')).toBeFalsy()
