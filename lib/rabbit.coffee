c = require 'node-config'
amqp = require 'amqp'
extend = require 'extend'
async = require 'async'
shared = require './shared'

###
Assumptions
  1 rabbit connection
  1+ queue
  1+ exchange

Example
  rabbit
    host:
    port:
    queues: [
      name:
      exchange: 
      opts:
    ]
    exchanges: [
      name:
      opts:
    ]
###

connection =

  newConnection: (cb) =>
    # create connection
    missing = shared.missingParameters ["host", "port"], c.rabbit
    if missing
      return cb new Error missing

    # now create a connection
    conn = amqp.createConnection 
      host: c.rabbit.host
      port: parseInt c.rabbit.port
    conn.on "ready", =>
      @app.rabbit ?= {}
      @app.rabbit.conn = conn
      cb?()
    conn.on "error", (err) =>
      conn.disconnect()
      return cb? err if err

  setUp: (cb) =>
    conn = (c.rabbit[key] for key in ["conn", "connection"] when c.rabbit[key]?)[0]

    if not conn?
      return connection.newConnection cb
    else
      @app.rabbit ?= {}
      @app.rabbit.conn = conn
      cb?()

  tearDown: (cb) =>
    # check if connection exists
    if not @app.rabbit.conn?
      return cb?()
    
    # now disconnect from amqp
    @app.rabbit.conn.disconnect()
    delete @app.rabbit.conn
    cb?()

exchange = 
  newExchange: (obj, cb) =>
    # make sure the correct params are passed
    missing = shared.missingParameters ["name", "key"], obj
    if missing
      return cb new Error missing

    # create options obj
    opts =
      confirm: true
    # pass in any user options
    if obj.opts?
      extend true, opts, obj.opts

    # now create exchange
    e = @app.rabbit.conn.exchange obj.name, opts
    e.on "open", =>
      # link up the exchange
      # generate the key
      @app.rabbit[if obj.key? then obj.key else obj.name] = e
      # create an array of the queues 
      @app.rabbit.exchanges ?= []
      @app.rabbit.exchanges.push e
      return do cb

    # handle signin error
    e.once "error", (err)=>
      return cb err if err

  setUp: (cb) =>
    # normalize the exchange object -> grab all excahnges
    e = if c.rabbit.exchanges? then c.rabbit.exchanges else if c.rabbit.exchange? then [c.rabbit.exchange] else null
    if not e?
      return cb?()
    
    # now call the bootstrap method for each exchange
    async.each e, exchange.newExchange, (err) =>
        return cb? err if err
        cb?()

  tearDown: (cb) =>
    # normalize the exchange object 
    e = if c.rabbit.exchanges? then c.rabbit.exchanges else if c.rabbit.exchange? then [c.rabbit.exchange] else null
    if not e?
      return cb?()

    # quick function for removing an individual queue
    _ = (key) =>
      # put in functionality for destroying if necessary / unbinding in the future
      # propose removign this helper function if necessary
      delete @app.rabbit[key]
    _ obj.key for obj in e
    cb?()
    
queue = 
  newQueue: (obj) =>

    # first create queue
    # second check to see if we need to bind
    cb?()

  setUp: (cb) =>
    # normalize queue/queues objects
    q = if c.rabbit.queues? then c.rabbit.queues else if c.rabbit.queue? then [c.rabbit.queue] else null
    if not q?
      return cb?()
    p "queus"
    # check 
    cb?()

  tearDown: (cb) =>
    # grab the queue
    # unbind if needed
    # if more than one exchange - then call this function multiple times
    cb?()

exports.setUp = (@app, cb) =>
  if not c.rabbit?
    return cb? null, @app
  # call all setUp methods
  async.waterfall [connection.setUp, exchange.setUp, queue.setUp], (err) =>
    cb err if err
    cb?()

exports.tearDown = (@app, cb) =>
  # call all tearDown methods
  async.waterfall [queue.tearDown, exchange.tearDown, connection.tearDown], (err) =>
    return cb? err if err?
    cb?()


