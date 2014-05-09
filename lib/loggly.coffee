loggly = require 'loggly'
c = require 'node-config'
shared = require "./shared"

logger = (message, args...) =>

  p length



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
  
  # now create the client
  client = loggly.createClient lObj  
  # handle an error
  if not client?




exports.tearDown = (app, cb) =>

  cb?()

