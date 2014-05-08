bootstrap = require "../bootstrap"
c = require 'node-config'
App = libRequire 'app'

bootstrap = (test, cb) =>
  c.set "postgres", @obj
  new App (err, app) => 
    @app = app
    cb?()

module.exports = 

  connSuite:
    setUp: (cb) =>
      @obj = {}
      cb?()

    connTest: (test) =>

      do test.done

  connStringSuite: 
    setUp: (cb) =>
      @obj = "postgres://test:test@localhost/test"
      cb?()

    connSuite: (test) =>
      bootstrap test, =>
        test.equals true, @app.postgres?
        
        @app.close =>
          do test.done
      


