bootstrap = require "../bootstrap"
c = require 'multi-config'

module.exports = 

  setUp: (cb) =>
    cb?()

  tearDown: (cb) =>

    @app.close =>
      cb?()

  logglyTest: (test) =>

    appBootstrap {daemon: true}, (@app) =>

      do test.done


