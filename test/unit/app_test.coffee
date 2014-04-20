bootstrap = require "../bootstrap"
config = require 'node-config'
App = libRequire 'app'

module.exports =

  setUp: (cb)->

    bootstrap.setUp =>
      App (err, app)=>
        p "HERE"
        cb?()

  tearDown: (cb)->

    cb?()

  test: (test)->

    do test.done


