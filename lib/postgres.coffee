c = require 'multi-config'
pg = null

exports.setUp = (app, cb) ->

  if not c.postgres?
    return cb?()

  pg ?= require 'pg'
  client = new pg.Client c.postgres
  client.connect (err) =>
    return cb err if err
    app.postgres = client
    cb?()

exports.tearDown = (app, cb) =>
  
  return cb?() if not app.postgres?
  do app.postgres.end
  delete app.postgres
  cb?()




