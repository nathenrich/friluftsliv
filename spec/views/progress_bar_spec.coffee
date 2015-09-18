ProgressBar = require '../../lib/scripts/views/progress_bar'

describe "ProgressBar", ->
  beforeEach ->
    @view = new ProgressBar({ @app, el: document.body }).render()

  afterEach ->
    @view.remove()

  describe "completion percentage", ->
    beforeEach ->
      @app.completion.set('percentComplete', 0)
      expect(@view.ui.percentComplete).toHaveText("0%")
      expect(@view.ui.progressBarAmount.css('width')).toEqual("0%")

    it "updates the percentage text when the model changes", ->
      @app.completion.set('percentComplete', 55)
      expect(@view.ui.percentComplete).toHaveText("55%")

    it "updates the progress bar", ->
      @app.completion.set('percentComplete', 22)
      expect(@view.ui.progressBarAmount.attr('style')).toMatch(/width: 22%;/)

