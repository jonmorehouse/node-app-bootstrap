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
  setUp: (cb) =>
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
      cb? err if err

  tearDown: (cb) =>

    # check if conncetion exists
    if not @app.rabbit.conn?
      return cb?()

    # now disconnect from amqp
    @app.rabbit.conn.disconnect()
    delete @app.rabbit.conn
    
    # disconnetct app's connection
    cb?()

exchange = 
  setUp: (cb) =>
    # check 
    cb?()

  tearDown: (cb) =>
    # if more than one exchange - then call this function multiple times
    cb?()

queue = 
  setUp: (cb) =>
    # check 
    cb?()

  tearDown: (cb) =>
    # if more than one exchange - then call this function multiple times
    cb?()

exports.setUp = (@app, cb) =>
  if not c.rabbit?
    return cb? null, @app

  # check for connection
  async.waterfall [connection.setUp, exchange.setUp, queue.setUp], (err) =>
    cb err if err
    cb?()

exports.tearDown = (@app, cb) =>
  # call all the correct methods
  async.waterfall [connection.tearDown, exchange.tearDown, queue.tearDown], (err) =>
    cb err if err
    cb?()



