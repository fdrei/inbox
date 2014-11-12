# file: src/core/index.coffee

EventEmitter = require('events').EventEmitter

class Core extends EventEmitter

  constructor: (@opts)->
    Datastore = require('nedb')
    @Person = @opts?.Person or require("#{__dirname}/PersonService")(
      persons: new Datastore { filename: 'db/persons', autoload: true }
    )


module.exports = (opts)->
  return new Core(opts)
