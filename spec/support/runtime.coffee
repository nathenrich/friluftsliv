course  = require '../fixtures/course'
lessons = require '../fixtures/lessons'
Runtime = require '../../lib/scripts/runtime'

beforeEach ->
  @app = new Runtime el: document.documentElement, data: { course, lessons }
