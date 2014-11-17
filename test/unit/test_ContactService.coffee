# file: test/unit/test_ContactService.coffee

should = require 'should'
sinon = require 'sinon'
helper = require("#{__dirname}/helper")()

describe 'ContactService', ->

  beforeEach ->
    # stub nedb
    @contacts = helper.getDatastoreStub()
    
    @service = require("#{__dirname}/../../src/core/ContactService")(
      contacts: @contacts
    )

  it 'should be awesome', ->
    @service.should.be.awesome


  describe 'add(contact, done)', ->

    it 'should add a new Contact'
    it 'should emit an error'
    it 'should callback an error'
