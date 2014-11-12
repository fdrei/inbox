# file: example/add_person.coffee

core = require("#{__dirname}/../src/core")()

# listen on any errors
core.on 'error', (err)->
  console.log err

# you can listen on specific events inside the PersonService
core.Person.on 'Person.add', (person, x)->
  console.log "New event 'Person.add': #{person.name}"

# without callback function
core.Person.add name: 'Patrick'
core.Person.add name: 'Krispin'

# with callback function
core.Person.add name: 'Burkhard', (err, person)->
  console.log "With callback: #{person.name}"

# get all persons
core.Person.getAll (err, persons)->
  console.log "all persons:"
  console.log persons

  # get person by its id
  core.Person.get persons[0]._id, (err, person)->
    console.log "get person by its id #{person._id}: #{person.name}"

    core.Person.remove name: 'Burkhard', (err, count)->
      console.log "removed #{count} persons"

      # remove all
      core.Person.removeAll (err, count)->
        console.log "removed all #{count} persons"
