# file: test/unit/test_PersonService.coffee

should = require 'should'
sinon = require 'sinon'
inspect = require('util').inspect

describe 'PersonService', ->

  beforeEach ->
    # fake persons
    @burkhard = name: 'Burkhard', _id: 1
    @patrick = name: 'Patrick', _id: 2
    @krispin = name: 'Krispin', _id: 3

    # stub nedb
    @persons =
      insert: sinon.stub()
      find: sinon.stub()
      findOne: sinon.stub()
      count: sinon.stub()
      remove: sinon.stub()

    @service = require("#{__dirname}/../../src/core/PersonService")(
      persons: @persons
    )

  it 'should be awesome', ->
    @service.should.be.awesome


  describe 'add(person, done)', ->

    beforeEach ->
      @persons.insert.withArgs(@burkhard).callsArgWith(1, null, @burkhard)
      @persons.insert.withArgs(@patrick).callsArgWith(1, new Error('something is wrong'))

    it 'should add a new Person', (done)->
      @service.add @burkhard, (err, person)=>
        person.should.have.property 'name', 'Burkhard'
        person.should.have.property '_id'
        @persons.insert.calledOnce.should.be.ok
        done err

    it 'should emit an error', (done)->
      @service.on 'error', (err)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.insert.calledOnce.should.be.ok
        done null
      @service.add @patrick

    it 'should callback an error', (done)->
      # add listener to prevent test from failing
      @service.on 'error', ->
      @service.add @patrick, (err, person)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        done null


  describe 'get(id, done)', ->

    beforeEach ->
      @persons.insert.withArgs(@patrick).callsArgWith(1, null, @patrick)
      @persons.findOne.withArgs(_id: @patrick._id).callsArgWith(1, null, @patrick)
      @persons.findOne.withArgs(_id: @burkhard._id).callsArgWith(1, new Error('something is wrong'))

    it 'should get a Person by its id', (done)->
      @service.get @patrick._id, (err, person)=>
        person.should.have.property 'name', 'Patrick'
        @persons.findOne.calledOnce.should.be.ok
        done err

    it 'should emit an error', (done)->
      @service.on 'error', (err)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        done null
      @service.get @burkhard._id

    it 'should callback an error', (done)->
      # add listener to prevent test from failing
      @service.on 'error', ->
      @service.get @burkhard._id, (err, person)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        done null


  describe 'getAll(done)', ->

    beforeEach ->
      @persons.find.withArgs({}).callsArgWith(1, null, [@burkhard, @patrick, @krispin])

    it 'should get all persons', (done)->
      @service.getAll (err, persons)=>
        persons.length.should.equal 3
        @persons.find.calledOnce.should.be.ok
        done err

    it 'should emit an error', (done)->
      @persons.find.withArgs({}).callsArgWith(1, new Error('something is wrong'))

      @service.on 'error', (err)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        done null
      @service.getAll()

    it 'should callback an error', (done)->
      @persons.find.withArgs({}).callsArgWith(1, new Error('something is wrong'))
      # add listener to prevent test from failing
      @service.on 'error', ->

      @service.getAll (err, persons)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        done null


  describe 'find(query, done)', ->

    beforeEach ->
      @persons.find.withArgs(name: 'Krispin').callsArgWith(1, null, [@krispin])
      @persons.find.withArgs(name: 'Patrick').callsArgWith(1, new Error('something is wrong'))

    it 'should find a Person by its name', (done)->
      @service.find name: 'Krispin', (err, persons)=>
        person = persons[0]
        person.should.have.property 'name', 'Krispin'
        @persons.find.calledOnce.should.be.ok
        done err

    it 'should emit an error', (done)->
      @service.on 'error', (err)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.find.calledOnce.should.be.ok
        done null
      @service.find name: 'Patrick'

    it 'should callback an error', (done)->
      # add listener to prevent test from failing
      @service.on 'error', ->
      @service.find name: 'Patrick', (err, persons)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.find.calledOnce.should.be.ok
        done null


  describe 'countAll(done)', ->

    beforeEach ->
      @persons.count.withArgs({}).callsArgWith(1, null, 3)

    it 'should count all persons', (done)->
      @service.countAll (err, count)=>
        count.should.equal 3
        @persons.count.calledOnce.should.be.ok
        done err

    it 'should emit an error', (done)->
      @persons.count.withArgs({}).callsArgWith(1, new Error('something is wrong'))
      @service.on 'error', (err)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.count.calledOnce.should.be.ok
        done null
      @service.countAll()

    it 'should callback an error', (done)->
      @persons.count.withArgs({}).callsArgWith(1, new Error('something is wrong'))
      # add listener to prevent test from failing
      @service.on 'error', ->
      @service.countAll (err, count)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.count.calledOnce.should.be.ok
        done null


  describe 'remove(query, done)', ->

    beforeEach ->
      @persons.remove.withArgs(name: 'Patrick').callsArgWith(2, null, 1)
      @persons.remove.withArgs(name: 'Krispin').callsArgWith(2, new Error('something is wrong'))

    it 'should remove a Person by its name', (done)->
      @service.remove name: 'Patrick', (err, count)=>
        count.should.equal 1
        @persons.remove.calledOnce.should.be.ok
        done err

    it 'should emit an error', (done)->
      @service.on 'error', (err)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.remove.calledOnce.should.be.ok
        done null
      @service.remove name:'Krispin'

    it 'should callback an error', (done)->
      # add listener to prevent test from failing
      @service.on 'error', ->
      @service.remove name: 'Krispin', (err, count)=>
        should(err).be.ok
        err.message.should.equal 'something is wrong'
        @persons.remove.calledOnce.should.be.ok
        done null
