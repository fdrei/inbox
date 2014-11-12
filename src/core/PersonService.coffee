# file: src/core/PersonService.coffee

debug = require('debug')('PersonService')
inspect = require('util').inspect
EventEmitter = require('events').EventEmitter


class PersonService extends EventEmitter

  constructor: (@opts)->
    debug "constructor"
    @db = @opts?.db or require('nedb')
    @persons = @opts?.persons or new @db()

  add: (person, done)->
    debug "add new person #{inspect person}"
    @persons.insert person, (err, doc)=>
      debug "person added #{inspect doc} with error #{inspect err}"
      @emit 'error', err if err?
      @emit 'Person.add', doc
      done err, doc if done?

  get: (id, done)->
    debug "get person by id #{id}..."
    @persons.findOne { _id: id }, (err, person)=>
      debug "...found person #{person}"
      @emit 'error', err if err?
      done err, person if done?

  getAll: (done)->
    @persons.find {}, (err, persons)=>
      @emit 'error', err if err?
      @emit 'PersonService.getAll', persons
      done err, persons if done?

  find: (query, done)->
    @persons.find query, (err, persons)=>
      @emit 'error', err if err?
      done err, persons if done?

  remove: (query, done)->
    options = {}
    @persons.remove query, options, (err, numRemoved)=>
      @emit 'error', err if err?
      done err, numRemoved if done?

  countAll: (done)->
    @persons.count {}, (err, count)=>
      @emit 'error', err if err?
      done err, count if done?


module.exports = (opts)->
  return new PersonService(opts)
