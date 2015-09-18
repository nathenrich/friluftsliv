Page    = require '../../lib/scripts/models/page'
Pages   = require '../../lib/scripts/collections/pages'


describe 'Pages collection', ->
  beforeEach ->
    @initialPage = new Page @app.lessons.first().attributes
    @pages  = new Pages [@initialPage]

  describe 'uses first lesson as initial', ->
    beforeEach ->
      @firstPage = @pages.first()

    it 'recognizes that page as "done"', ->
      expect(@firstPage.get 'transition').toEqual 'done'

    describe 'and then a new page is added', ->
      beforeEach ->
        @lesson = @app.lessons.at 1
        @pages.add @lesson.attributes
        @newPage = @pages.get @lesson.id

      it 'assigns the correct transition to the new page', ->
        expect(@newPage.get 'transition').toEqual 'next'

      it 'assigns the correct transition to the current page', ->
        expect(@firstPage.get 'transition').toEqual 'previous'
