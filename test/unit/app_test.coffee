bootstrap = require "../bootstrap"
config = require 'node-config'

module.exports =

  setUp: (cb)->

    bootstrap.setUp ->

      cb?()

  tearDown: (cb)->

    cb?()

  test: (test)->

    do test.done


