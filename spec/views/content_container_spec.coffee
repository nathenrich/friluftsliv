ContentContainer = require '../../lib/scripts/views/content_container'

describe 'ContentContainer', ->
  beforeEach ->
    @app.lessons.first().select()
    @view = new ContentContainer({ @app, el: document.body }).render()
    @view.onRender()

  afterEach ->
    @view.remove()

  describe 'onRender', ->
    it "binds a new page to elements rendered server-side", ->
      expect(@view.children.size()).toEqual 1

  describe 'when a new lesson is selected', ->
    beforeEach ->
      spyOn(@view.collection, 'add').and.callThrough()
      @second = @app.lessons.at(1)
      @second.select()

    it 'adds the lesson to the collection of pages', ->
      expect(@view.collection.add).toHaveBeenCalledWith @second.attributes

    it 'renders a new child view for that page', ->
      expect(@view.children.size()).toEqual 2
