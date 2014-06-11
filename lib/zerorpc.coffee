c = require 'multi-config'
shared = require "./shared"
zerorpc = null

exports.setUp = (app, cb) ->

  return cb?() if not c.zerorpc?
  zerorpc ?= require 'zerorpc'

  opts = if c.zerorpc.opts? then c.zerorpc.opts else {}
  host = if c.zerorpc.host? then c.zerorpc.host else "tcp://127.0.0.1:4242"
  # normalize arguments
  if typeof c.zerorpc is "string"
    host = c.zerorpc

  app.zerorpc = new zerorpc.Client()
  app.zerorpc.connect host
  cb?()

exports.tearDown = (app, cb) ->

  return cb?() if not app.zerorpc?
  do app.zerorpc.close
  delete app["zerorpc"]
  cb?()

