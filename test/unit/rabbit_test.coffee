bootstrap = require "../bootstrap"
c = require 'node-config'
App = libRequire 'app'

bootstrap = (test, cb) =>
  c.set "rabbit", @obj
  new App (err, app) =>
    test.equal false, err?
    test.equal true, app?
    @app = app
    cb app

module.exports = 

  setUp: (cb) =>
    cb?()

  tearDown: (cb) =>
    cb?()

  connSuite:

    objTest: (test) =>
      @obj = 
        conn:
          host: "localhost"
          port: 5672

      bootstrap test, =>
        
        p @app
        do test.done

    connObjTest: (test) ->
      do test.done


    errTest: (test) ->
      do test.done







