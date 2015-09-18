LmsProxy        = require '../lib/scripts/lms_proxy'
Lessons         = require '../lib/scripts/collections/lessons'
Completion      = require '../lib/scripts/models/completion'
Backbone        = require 'backbone'
_               = require 'underscore'

describe 'LMS Proxy', ->
  beforeEach ->
    @vent = _.extend {}, Backbone.Events
    @lessons = new Lessons
    @app = { @vent, @lessons }
    @completion = new Completion {}, { lessons: @lessons, @app }

  describe 'when Scorm Driver is not available', ->
    beforeEach ->
      spyOn(LmsProxy::, 'onLmsCompletion').and.callThrough()
      @proxy = new LmsProxy
        vent: @vent
        lessons: @lessons
        completion: @completion
      ,
        statusType: "completedIncomplete"
        trackBy: "numLessons"
        trackByNumLessons: 11,
        trackByQuizId:"123"

    it 'does not respond to lms:completion event', ->
      @vent.trigger 'lms:completion'
      expect(@proxy.onLmsCompletion).not.toHaveBeenCalled()

  describe 'when Scorm Driver is available', ->
    beforeEach ->
      @scormDriver = jasmine.createSpyObj(LmsProxy.SCORM_DRIVER_FUNCTIONS)
      _.extend window.parent, @scormDriver

    afterEach ->
      _(LmsProxy.SCORM_DRIVER_FUNCTIONS).each (fn) ->
        delete window.parent[fn]

    describe 'when lms is not available', ->
      beforeEach ->
        window.parent.IsLoaded.and.returnValue false
        spyOn(LmsProxy::, 'onLmsCompletion').and.callThrough()
        @proxy = new LmsProxy
          vent: @vent
          lessons: @lessons
          completion: @completion
        ,
          statusType: "completedIncomplete"
          trackBy: "numLessons"
          trackByNumLessons: 11
          trackByQuizId: "123"

      it 'calls IsLoaded on stand up', ->
        expect(window.parent.IsLoaded).toHaveBeenCalled()

      describe 'lms:completion event', ->
        it 'does not respond to lms:completion event', ->
          @vent.trigger 'lms:completion'
          expect(@proxy.onLmsCompletion).not.toHaveBeenCalled()

    describe 'when lms is available', ->
      beforeEach ->
        window.parent.IsLoaded.and.returnValue true
        spyOn(LmsProxy::, 'onLmsCompletion').and.callThrough()
        spyOn(LmsProxy::, 'onLmsStop').and.callThrough()
        spyOn(LmsProxy::, 'saveCurrentLocation').and.callThrough()
        @proxy = new LmsProxy
          vent: @vent
          lessons: @lessons
          completion: @completion
        ,
          statusType: "completedIncomplete"
          trackBy: "numLessons"
          trackByNumLessons: 11
          trackByQuizId:"123"

      it 'calls IsLoaded on stand up', ->
        expect(window.parent.IsLoaded).toHaveBeenCalled()

      describe 'lms:completion event', ->
        it 'responds to lms:completion event', ->
          @vent.trigger 'lms:completion'
          expect(@proxy.onLmsCompletion).toHaveBeenCalled()

        describe 'when complete', ->
          beforeEach ->
            @vent.trigger 'lms:completion', 11

          it 'calls SetReachedEnd when triggered', ->
            expect(window.parent.SetReachedEnd).toHaveBeenCalled()

          it 'calls CommitData when triggered', ->
            expect(window.parent.CommitData).toHaveBeenCalled()

        describe 'when incomplete', ->
          beforeEach ->
            @vent.trigger 'lms:completion', 1

          it 'calls SetReachedEnd when triggered', ->
            expect(window.parent.SetReachedEnd).not.toHaveBeenCalled()

          it 'calls CommitData when triggered', ->
            expect(window.parent.CommitData).toHaveBeenCalled()

      describe 'when lms:stop event', ->
        it 'responds to lms:stop', ->
          @vent.trigger 'lms:stop'
          expect(@proxy.onLmsStop).toHaveBeenCalled()

      describe 'when change:selected', ->
        it 'responds to change:selected', ->
          @lessons.trigger 'change:selected'
          expect(@proxy.saveCurrentLocation).toHaveBeenCalled()
