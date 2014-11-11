# file: test/unit/test_PersonService.coffee

should = require 'should'

describe 'PersonService', ->

  beforeEach ->
    @service = require("#{__dirname}/../../src/core/PersonService")()

  it 'should be awesome', ->
    @service.should.be.awesome
