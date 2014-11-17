# file: src/core/ContactService.coffee

###

A Contact is a Message chain between 2 or more Persons.
It has a start time, involved Persons and the Messages
that were send between them.
Messages are linked to each other through the
same Contact id. If you reply to a Message then it belongs
to the same Contact.

The ContactService handles all these Contacts.

###

debug = require('debug')('ContactService')
inspect = require('util').inspect
EventEmitter = require('events').EventEmitter

class ContactService extends EventEmitter

  constructor: (@opts)->
    debug 'constructor'
    # datastore
    @contacts = @opts?.contacts

  add: (contact, done)->
    debug "add new contact #{inspect contact}"
    @contacts.insert contact, (err, doc)=>
      debug "contact added #{inspect doc} with error #{inspect err}"
      @emit 'error', err if err?
      @emit 'Contact.add', doc
      done err, doc if done?


module.exports = (opts)->
  return new ContactService(opts)
