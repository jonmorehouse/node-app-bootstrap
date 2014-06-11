c = require 'multi-config'
redis = null
shared = require "./shared"

exports.setUp = (app, cb) ->

  if not c.redis?
    return cb?()
  
  redis ?= require 'redis'

  missing = shared.missingParameters ["host", "port"], c.redis
  if missing
    return cb new Error missing

  opts = c.redis.opts ? c.redis.opts ? {} 
  app.redis = redis.createClient parseInt(c.redis.port), c.redis.host, opts
  cb?()

exports.tearDown = (app, cb) ->
  
  if not app.redis?
    return cb?()
  
  redis ?= require 'redis'
  app.redis.end()
  delete app.redis
  cb?()

