# file: src/core/PersonService.coffee

EventEmitter = require('events').EventEmitter

class PersonService extends EventEmitter

  constructor: (@opts)->
    @db = @opts?.db or require('nedb')
    @persons = new @db()

  add: (person, done)->
    @persons.insert person, (err, doc)=>
      @emit 'error', err if err
      @emit 'Person.add', doc
      done err, doc if done?

  get: (id, done)->
    @persons.findOne { _id: id }, done

  find: (query, projection, done)->
    @persons.find query, projection, done

  remove: (query, options, done)->
    @persons.remove query, options, (err, numRemoved)=>
      @emit 'error', err if err
      done err, numRemoved


module.exports = (opts)->
  return new PersonService(opts)
