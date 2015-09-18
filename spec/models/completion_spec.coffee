describe 'Completion model', ->
  beforeEach ->
    { @completion } = @app
    @lessons = @completion.get 'lessons'

  describe "when a lesson's completion state changes", ->
    beforeEach ->
      @lessons.invoke 'set', completed: false
      @lessons.first().set completed: true

    it 'recalculates the percent_complete', ->
      expect(@completion.get 'percentComplete').toEqual 9

    it 'updates the completed_at timestamp for that lesson', ->
      expect(@lessons.first().get 'completed_at').not.toBeNull()

  describe 'when some lessons are incomplete', ->
    beforeEach ->
      @lessons.invoke 'set', completed: false
      @lessons.first().set completed: true

    it 'sets the course to completed: false', ->
      expect(@completion.get 'completed').toEqual false

  describe 'when all lessons are completed', ->
    beforeEach ->
      @lessons.invoke 'set', completed: true

    it 'sets the course to completed: true', ->
      expect(@completion.get 'completed').toEqual true

    it 'updates the completed_at timestamp', ->
      expect(@completion.get 'completed_at').not.toBeNull()

  describe '#toggleCompleted', ->
    beforeEach ->
      @lesson = @lessons.first()

    describe 'when update succeeds', ->
      beforeEach ->
        spyOn @completion, 'save'

      it 'toggles the completion of the lesson', ->
        completed = @lesson.get 'completed'
        @completion.toggleCompleted @lesson
        expect(@lesson.get 'completed').toEqual !completed

      it 'attempts to save the completion data', ->
        @completion.toggleCompleted @lesson
        expect(@completion.save).toHaveBeenCalled()

    describe 'when update fails', ->
      beforeEach ->
        spyOn(@completion, 'save').and.callFake (data, options) ->
          options.error()

      it 'reverts the changed completion state', ->
        completed = @lesson.get 'completed'
        @completion.toggleCompleted @lesson
        expect(@lesson.get 'completed').toEqual completed
