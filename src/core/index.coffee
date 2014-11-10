# file: src/core/index.coffee

EventEmitter = require('events').EventEmitter

class Core extends EventEmitter

  constructor: (@opts)->
    @persons = @opts?.persons or require("#{__dirname}/PersonService")()


module.exports = (opts)->
  return new Core(opts)
