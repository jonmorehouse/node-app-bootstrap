async = require 'async'
events = require 'events'

class App extends events.EventEmitter

  @components = 
    rabbit: require "./rabbit"
    postgresql: require "./postgresql"
    paperTrail: require "./paper_trail"
    airBrake: require "./air_brake"

  constructor: (cb)->

    super

  triggerClose: (msg)->
    @emit "close", msg

  close: (cb)->

###
class App extends bootstrap.App

  @components["rabbit"] = require "./my_custom_rabbit_wrapper"

  constructor: (cb)->

    # bootstrap app
    super
    # bootstrap app
    cb?()

  close: (cb)->

    # close down your own app
    super

# now startup application
new App opts, (err, app)->

  #app is now ready!
  app.doThings

  app.on "close", (msg)->

    # shutdown app
    # trigger close

  app.error msg, FATAL=false

  app.logger app.logger.SEVERE, msg

###


  



