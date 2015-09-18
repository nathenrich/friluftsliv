result = require 'lodash/object/result'

Lesson  = require '../../lib/scripts/models/lesson'

describe 'Lessons collection', ->
  beforeEach ->
    { @lessons } = @app

  describe '#model', ->
    it 'instantiates each model into a Lesson', ->
      expect(@lessons.first() instanceof Lesson).toBeTruthy()

  describe '#selectById', ->
    beforeEach ->
      @id = 1
      spyOn @lessons.first(), 'selectById'
      @lessons.selectById @id

    it 'invokes down to the lessons', ->
      expect(@lessons.first().selectById).toHaveBeenCalledWith @id

  describe '#selectedLesson', ->
    beforeEach ->
      @lessons.selectById @lessons.first().id

    it 'finds the currently selected lesson', ->
      expect(@lessons.selectedLesson()).toEqual @lessons.first()

  describe '#next', ->
    it "returns next lesson", ->
      current = @lessons.at 0
      next    = @lessons.at 1
      expect(@lessons.next current).toEqual next

    it "returns undefined if no next", ->
      current = @lessons.last()
      expect(@lessons.next current).toBeUndefined()

  describe '#previous', ->
    it "returns previous lesson", ->
      current = @lessons.last()
      next    = @lessons.at(@lessons.length - 2)
      expect(@lessons.previous current).toEqual next

    it "returns undefined if no previous", ->
      current = @lessons.first()
      expect(@lessons.previous current).toBeUndefined()

  describe '#contentTypeCounts', ->
    it "maps counts of lesson types", ->
      expect(@lessons.contentTypeCounts()).toContain
        type: 'process'
        count: 1
