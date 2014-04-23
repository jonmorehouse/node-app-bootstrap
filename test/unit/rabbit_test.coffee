bootstrap = require "../bootstrap"
c = require 'node-config'
App = libRequire 'app'

module.exports = 

  setUp: (cb) ->

    c.

    cb?()

  tearDown: (cb) ->

    cb?()


  connSuite:

    objTest: (test)->


      do test.done


    connObjTest: (test)->

      do test.done


    errTest: (test)->

      do test.done







