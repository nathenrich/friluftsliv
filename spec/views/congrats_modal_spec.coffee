CongratsModal = require '../../lib/scripts/views/congrats_modal'

describe 'CongratsModal view', ->
  beforeEach ->
    @app.completion.set completed: false
    @view = new CongratsModal({ @app, el: document.body }).render()

  afterEach ->
    @view.remove()

  it 'defaults to hidden', ->
    expect(@view.model.get 'visible').toBeFalsy()

  describe 'when modal becomes visible', ->
    beforeEach ->
      @view.model.set visible: true

    it 'shows the modal', ->
      expect(@view.$el).toHaveClass 'modal--show'

  describe 'when modal is not visible', ->
    beforeEach ->
      @view.model.set visible: false

    it 'hides the modal', ->
      expect(@view.$el).not.toHaveClass 'modal--show'

  describe 'when close button is clicked', ->
    beforeEach ->
      @view.ui.close.click()

    it 'hides the modal', ->
      expect(@view.model.get 'visible').toBeFalsy()

  describe 'when all lesson become completed', ->
    beforeEach ->
      @app.completion.set completed: true

    it 'shows the modal', ->
      expect(@view.model.get 'visible').toBeTruthy()
