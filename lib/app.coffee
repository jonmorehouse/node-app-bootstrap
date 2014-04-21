async = require 'async'
events = require 'events'

class App extends events.EventEmitter

  @components = 
    rabbit: require "./rabbit"
    #redis: require "./redis"
    #postgresql: require "./postgresql"
    #paperTrail: require "./paper_trail"
    #airBrake: require "./air_brake"

  constructor: (cb) ->
    super
    @_caller "setUp", cb

  close: (cb) ->

    # if there are listeners
    if @listeners("close").length > 0
      @emit "close", => 
        @_caller "tearDown", cb
    else 
      @_caller "tearDown", cb

  _caller: (method, cb) ->

    # grab all the relevant functions
    functions = (component[method] for key, component of App.components)

    # call each function and bootstrap it properly
    async.each functions, ((method, cb)=> method @, cb), (err)=>
      return cb err if err
      cb? null, @

module.exports = App
