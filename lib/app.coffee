async = require 'async'
events = require 'events'

class App extends events.EventEmitter

  @components =
    rabbit: require "./rabbit"
    postgresql: require "./postgres"
    loggly: require "./loggly"
    redis: require "./redis"
    zerorpc: require "./zerorpc"

  constructor: (cb) ->
    super
    @_caller "setUp", (err, app) =>
    
      # call etcd - register function here ...
      cb err, app

  close: (cb) ->
    # if there are listeners
    if @listeners("close").length > 0
      @emit "close", => 
        @_caller "tearDown", cb
    else 
      @_caller "tearDown", cb

  _caller: (method, cb) =>

    # grab all the relevant functions
    functions = (component[method] for key, component of App.components)

    # call each function and bootstrap it properly
    async.eachSeries functions, ((method, cb) => method @, cb), (err) =>
      return cb err if err
      cb? null, @

module.exports = App
