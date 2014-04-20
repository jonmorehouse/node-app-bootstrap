async = require 'async'
events = require 'events'

class App extends events.EventEmitter

  @components = 
    rabbit: require "./rabbit"
    postgresql: require "./postgresql"
    paperTrail: require "./paper_trail"
    airBrake: require "./air_brake"

  constructor: (cb)->

    functions = (component.function for key, component of App.components)

    p functions

    super

  triggerClose: (msg)->
    @emit "close", msg

  close: (cb)->



module.exports = App
