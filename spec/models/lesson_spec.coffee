describe 'Lesson model', ->
  beforeEach ->
    { @lessons } = @app
    @lesson = @lessons.first()
    spyOn @lessons, 'next'
    spyOn @lessons, 'previous'
    spyOn @lessons, 'selectById'

  describe 'defaults', ->
    it 'selected: false', ->
      expect(@lesson.get 'selected').toBeFalsy()

  describe '#selectById', ->
    it 'sets selected: true when id matches', ->
      @lesson.selectById @lesson.id
      expect(@lesson.get 'selected').toBeTruthy()

    it "sets selected: false when id doesn't match", ->
      @lesson.selectById 'wrong-id'
      expect(@lesson.get 'selected').toBeFalsy()

  describe '#select', ->
    beforeEach ->
      @lesson.select()

    it "calls select by id on collection", ->
      expect(@lesson.collection.selectById).toHaveBeenCalledWith(@lesson.id)

  describe '#nextLesson', ->
    beforeEach ->
      @lesson.nextLesson()

    it "asks the collection for the next lesson", ->
      expect(@lessons.next).toHaveBeenCalledWith @lesson

  describe '#previousLesson', ->
    beforeEach ->
      @lesson.previousLesson()

    it "asks the collection for the previous lesson", ->
      expect(@lessons.previous).toHaveBeenCalledWith @lesson

  describe '#isSection', ->
    describe 'when content is an object', ->
      beforeEach ->
        @lesson.set('content', {})

      it 'is false', ->
        expect(@lesson.isSection()).toEqual false

    describe 'when content is undefined', ->
      beforeEach ->
        @lesson.unset('content')

      it 'is true', ->
        expect(@lesson.isSection()).toEqual true

    describe 'when content is null', ->
      beforeEach ->
        @lesson.set('content', null)

      it 'is true', ->
        expect(@lesson.isSection()).toEqual true
