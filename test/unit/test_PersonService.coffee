# file: test/unit/test_PersonService.coffee

should = require 'should'

describe 'PersonService', ->

  beforeEach ->
    # fake persons
    @burkhard = name: 'Burkhard'
    @patrick = name: 'Patrick'
    @krispin = name: 'Krispin'

    @service = require("#{__dirname}/../../src/core/PersonService")()

  it 'should be awesome', ->
    @service.should.be.awesome

  describe 'add(person, done)', ->

    it 'should add a new Person', (done)->
      @service.add @burkhard, (err, person)=>
        person.should.have.property 'name', 'Burkhard'
        person.should.have.property '_id'
        done err

  describe 'get(id, done)', ->

    beforeEach (done)->
      @service.add @patrick, (err, person)=>
        @person_id = person._id
        done err

    it 'should get a Person by its id', (done)->
      @service.get @person_id, (err, person)=>
        person.should.have.property 'name', 'Patrick'
        done err

  describe 'find(query, projection, done)', ->

    beforeEach (done)->
      @service.add @krispin, done

    it 'should find a Person by its name', (done)->
      @service.find name: 'Krispin', {}, (err, persons)=>
        person = persons[0]
        person.should.have.property 'name', 'Krispin'
        done err

  describe 'remove(query, options, done)', ->

    beforeEach (done)->
      @service.add @patrick, (err, person)=>
        @person_id = person._id
        done err

    it 'should remove a Person by its name', (done)->
      @service.remove name: 'Patrick', (err, count)=>
        done err
