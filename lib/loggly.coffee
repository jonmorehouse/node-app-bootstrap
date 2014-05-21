loggly = require 'loggly'
c = require 'multi-config'
shared = require "./shared"

exports.setUp = (app, cb) =>

  if not c.loggly?
    return cb?()

  missing = shared.missingParameters ["token", "subdomain", "username", "password", "tags"], c.loggly
  if missing 
    return cb new Error missing

  # generate the loggly client and set it as an app attribute
  cObj = c.loggly
  lObj = # remap of the loggly configuration
    token: cObj.token
    subdomain: cObj.subdomain
    auth:
      username: cObj.username
      password: cObj.password
    tags: if cObj.tags? then cObj.tags else []
    json: if cObj.json? then cObj.json else true
  
  # create loggly client
  client = loggly.createClient lObj  

  # map it to the app bootstrap
  app.loggly = client
  app.log = (msg, args...) ->
    @loggly.log msg, args...
  cb?()

exports.tearDown = (app, cb) =>

  if app.loggly? 
    delete app.loggly
  if app.log?
    delete app.log
  cb?()

