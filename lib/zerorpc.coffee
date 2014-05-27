c = require 'multi-config'
zerorpc = require 'zerorpc'
shared = require "./shared"

exports.setUp = (app, cb) ->

  return cb?() if not c.zerorpc?

  opts = if c.zerorpc.opts? then c.zerorpc.opts else {}
  host = if c.zerorpc.host? then c.zerorpc.host else "tcp://127.0.0.1:4242"
  obj = null
  # normalize arguments
  if typeof c.zerorpc is "string"
    host = c.zerorpc
  else if typeof c.zerorpc is "object"
    for key in ["obj", "object", "context"]
      if key of c.zerorpc and c.zerorpc[key]? then obj = c.zerorpc[key]

  # set up client or server 
  if not obj?
    app.zerorpcClient = zerorpc.Client opts
    app.zerorpcClient.connect 

  else # server mode
    app.zerorpcServer = zerorpc.Server 

  cb?()

exports.tearDown = (app, cb) ->

  cb?()

