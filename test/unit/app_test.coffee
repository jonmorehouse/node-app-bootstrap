bootstrap = require "../bootstrap"
config = require 'node-config'
app = libRequire 'app'

module.exports =

  setUp: (cb)->

    bootstrap.setUp =>

      new app.App =>

        p "HERE"
      
        cb?()

  tearDown: (cb)->

    cb?()

  test: (test)->

    do test.done


