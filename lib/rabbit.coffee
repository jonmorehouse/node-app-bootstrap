config = require 'node-config'
amqp = require 'amqp'
extend = require 'extend'
async = require 'async'

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
  setUp: (app, cb) ->
    cb?()

  tearDown: (app, cb) ->

exchange = 
  setUp: (app, obj, cb)->

    # if more than one exchange - then call this function multiple times
    cb?()


  tearDown: (queue, cb)->

queue = (app) ->
  setUp: (app, cb) ->
    # here I am
    cb?()

  tearDown: (app, cb) ->
    # 


exports.setUp = (app, cb) ->

  if not app.rabbit?
    return cb? null, app

  # check for connection
  async.waterfall [conn.setUp, exchange.setUp, queue.setUp], (cb)->

    cb?()


exports.tearDown = (app, cb) ->

  cb?()
