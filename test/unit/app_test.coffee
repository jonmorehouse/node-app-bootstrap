bootstrap = require "../bootstrap"
config = require 'node-config'
extend = require 'extend'
App = libRequire 'app'

module.exports = 

  # global setup
  setUp: (cb)=>

    # initailize spy and spy counter 
    @called = 0
    @spy = (app, cb)=>
      @called += 1
      cb?()

    # switch out the components as needed
    @components = extend {}, App.components
    # now inject the spy into the correct app component methods
    for key, obj of App.components
      obj.setUp = @spy
      obj.tearDown = @spy
      
    cb?()

  tearDown: (cb)=>

    App.components = @components
    cb?()

  # bootstrap suite - make sure the app bootstraps properly
  bootstrap_suite: 

    setUp: (cb)=>
      new App (err, app)=>
        @app = app
        cb?()

    tearDown: (cb)=>
      
      @app.close =>
        cb?()

    # ensure that all teh setUp methods are called
    testBootstrappedProperly: (test)=>
      
      test.equals @called, (key for key of @components).length
      do test.done

  # closing suite - make sure that the event emissions are called as needed
  close_suite: 

    setUp: (cb)=>
      new App (err, app)=>
        @app = app
        cb?()

    testCloseEmission: (test)=>

      called = 0
      @app.on "close", (cb)=>

        test.equals true, cb?
        test.equals 0, called
        called += 1
        cb?()

      # final callback
      _ = (cb)->
        test.equals 1, called
        do test.done

      @app.close _

    testCloseCall: (test)=>

      do test.done


