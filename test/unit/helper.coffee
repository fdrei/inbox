# file: test/unit/helper.coffee

sinon = require 'sinon'

class Helper

  getDatastoreStub: ->
    stub =
      insert: sinon.stub()
      find: sinon.stub()
      findOne: sinon.stub()
      count: sinon.stub()
      remove: sinon.stub()
    return stub

module.exports = ->
  return new Helper()
