# file: src/core/PluginServicecoffee

debug = require('debug')('PluginService')
inspect = require('util').inspect
EventEmitter = require('events').EventEmitter

class PluginService extends EventEmitter

  constructor: (@opts)->
    # datastore
    @plugins = @opts?.persons



module.exports = (opts)->
  return new PluginService(opts)
