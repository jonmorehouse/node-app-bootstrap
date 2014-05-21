c = require 'multi-config'
pg = require 'pg'

exports.setUp = (app, cb) ->

  if not c.postgres?
    return cb?()

  client = new pg.Client c.postgres
  client.connect (err) =>
    return cb err if err
    app.postgres = client
    cb?()

exports.tearDown = (app, cb) =>
  
  if not app.postgres?
    return cb?()

  if app.postgres
    do app.postgres.end
    delete app.postgres
  cb?()




