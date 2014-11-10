# file: example/add_person.coffee

core = require("#{__dirname}/../src/core")()

# you can listen on specific events inside the PersonService
core.persons.on 'Person.add', (person, x)->
  console.log "new event 'Person.add': #{person.name}"

# without callback function
core.persons.add name: 'Patrick'

# with callback function
core.persons.add name: 'Burkhard', (err, person)->
  console.log "with callback: #{person.name}"

# find all persons
core.persons.find {}, {}, (err, persons)->
  console.log "all persons:"
  console.log persons

  # get person by its id
  core.persons.get persons[0]._id, (err, person)->
    console.log "get person by its id #{person._id}: #{person.name}"

core.persons.remove name: 'Burkhard', {}, (err, count)->
  console.log "removed #{count} persons: #{person.name}"
