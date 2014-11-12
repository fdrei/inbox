# file: src/core/PersonService.coffee

debug = require('debug')('PersonService')
EventEmitter = require('events').EventEmitter


class PersonService extends EventEmitter

  constructor: (@opts)->
    debug "constructor"
    @db = @opts?.db or require('nedb')
    @persons = new @db()

  add: (person, done)->
    debug "add new person #{person}"
    @persons.insert person, (err, doc)=>
      debug "person added #{doc} with error #{err}"
      @emit 'error', err if err
      @emit 'Person.add', doc
      done err, doc if done?

  get: (id, done)->
    @persons.findOne { _id: id }, (err, person)=>
      done err, person

  find: (query, projection, done)->
    @persons.find query, projection, done

  remove: (query, options, done)->
    @persons.remove query, options, (err, numRemoved)=>
      @emit 'error', err if err
      done err, numRemoved

  countAll: (done)->
    @persons.count {}, (err, count)=>
      @emit 'error', err if err
      done err, count


module.exports = (opts)->
  return new PersonService(opts)
