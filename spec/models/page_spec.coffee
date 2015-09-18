Page    = require '../../lib/scripts/models/page'

describe 'Page model', ->
  beforeEach ->
    @pages = jasmine.createSpyObj 'Pages', ['remove']
    @page  = new Page @app.lessons.first().attributes, collection: @pages
    jasmine.clock().install()

  afterEach ->
    jasmine.clock().uninstall()

  describe 'when just added to collection', ->
    describe 'and new transition set', ->
      beforeEach ->
        @page.set transition: 'current'

      it 'does not remove page from collection', ->
        expect(@pages.remove).not.toHaveBeenCalled()

  describe 'when page is the current one', ->
    beforeEach ->
      @page.set transition: 'current'

    describe 'and a new transition is set', ->
      beforeEach ->
        @page.set transition: 'next'
        jasmine.clock().tick 251

      it 'removes the page from the collection', ->
        expect(@pages.remove).toHaveBeenCalledWith @page

  describe '#transitionTo', ->
    beforeEach ->
      @number = @page.get 'number'

    describe 'next (or later) lesson', ->
      beforeEach ->
        @page.transitionTo @number + 1

      it 'sets this page to previous', ->
        expect(@page.get 'transition').toEqual 'previous'

    describe 'this lesson', ->
      beforeEach ->
        @page.transitionTo @number
        jasmine.clock().tick 251

      it 'sets this page to current (after a timeout)', ->
        expect(@page.get 'transition').toEqual 'current'

    describe 'previous lesson', ->
      beforeEach ->
        @page.transitionTo @number - 1

      it 'sets this page to next', ->
        expect(@page.get 'transition').toEqual 'next'
