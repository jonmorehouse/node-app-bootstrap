bootstrap = require "../bootstrap"
c = require 'node-config'

module.exports = 

  setUp: (cb) =>
    cb?()

  connSuite:
    setUp: (cb) =>
      @obj = {}
      cb?()

    connTest: (test) =>

      do test.done

  connStringSuite: 
    setUp: (cb) =>
      @obj = 
        postgres: "postgres://test:test@localhost/test"
      cb?()

    testConn: (test) =>
      appBootstrap @obj, (@app) =>
        test.equals true, @app.postgres?
        @app.close =>
          do test.done
      
  connObjSuite:
    setUp: (cb) =>

      cb?()

    testConn: (test) =>

      do test.done



