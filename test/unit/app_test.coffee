bootstrap = require "../bootstrap"
config = require 'node-config'
App = libRequire 'app'

exports.suite =

  setUp: (cb)->

    bootstrap.setUp =>
      new App (err, app)=>
        @app = app
        cb?()

  tearDown: (cb)->

    @app.close()

    cb?()

  test: (test)->

    do test.done

exports.close_suite = 

  setUp: (cb)->

    bootstrap.setUp =>
      new App (err, app)=>
        @app = app
        cb?()

  tearDown: (cb)->

    cb?()

  testListener: (test)->

    @app.on "close", (cb)->

      do test.done

    @app.close()




