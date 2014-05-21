bootstrap = require "../bootstrap"
config = require 'multi-config'
extend = require 'extend'
App = libRequire "app"

module.exports = 

  # global setup
  setUp: (cb) =>
    # initailize spy and spy counter 
    @called = 0
    @spy = (app, cb) =>
      @called += 1
      cb?()

    # switch out the components as needed
    @components = extend true, {}, App.components
    # now inject the spy into the correct app component methods
    for key, obj of App.components
      obj.setUp = @spy
      obj.tearDown = @spy
      
    new App (err, app) =>
      @app = app
      cb?()

  tearDown: (cb) =>
    App.components = @components
    cb?()

  # bootstrap suite - make sure the app bootstraps properly
  suite: 
    tearDown: (cb) =>
      @app.close =>
        cb?()

    # ensure that all the setUp methods are called
    testBootstrappedProperly: (test) =>
      test.equals @called, (key for key of @components).length
      do test.done
  
  suite_teardown:
    testTeardownsCalled: (test) =>
      # make sure all teardown functions were called
      do test.done

  # closing suite - make sure that the event emissions are called as needed
  close_suite: 
    # call close with a cb
    # listener is notified / passed a cb
    # it runs cb which shuts down app and then calls the close cb (if passed)
    testCloseEmission: (test) =>
      called = 0
      @app.on "close", (cb) =>
        test.equals true, cb?
        test.equals 0, called
        called += 1
        cb?()

      # final callback
      _ = (cb) ->
        test.equals 1, called
        do test.done

      @app.close _

    testCloseCall: (test) =>
      @app.close =>
        do test.done


