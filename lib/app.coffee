async = require 'async'
events = require 'events'

class App #@ extends events.EventEmitter

  @components = 
    rabbit: require "./rabbit"
    #redis: require "./redis"
    #postgresql: require "./postgresql"
    #paperTrail: require "./paper_trail"
    #airBrake: require "./air_brake"

  constructor: (cb)->
    #super()
    @_caller "setUp", cb


  close: (cb)->
    @caller "tearDown", cb

  triggerClose: (msg)->
    @emit "close", msg

  _caller: (method, cb)->

    p "HERE"
    # grab all the relevant functions
    functions = (component[method] for key, component of App.components)

    # call each function and bootstrap it properly
    async.each functions, ((method, cb)=> method @, cb), (err)=>
      return cb err if err
      cb?()

module.exports = App


