config = require 'node-config'
amqp = require 'amqp'
extend = require 'extend'

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

conn =
  setUp: (app, cb) ->

  tearDown: (app, cb) ->

exchanges = 
  setUp: (app, obj, cb)->


  tearDown: (queue, cb)->

queues = (app) ->

exports.setUp = (app, cb) ->

  if not app.rabbit?
    return cb? null, app

  cb?()

exports.tearDown = (app, cb) ->

  cb?()
