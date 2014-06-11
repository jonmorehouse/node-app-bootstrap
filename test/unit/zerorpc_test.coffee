bootstrap = require "../bootstrap"
c = require "multi-config"
zpc = require "zerorpc"

clientTest = (app, test) ->

  test.equal true, app.zerorpc?
  app.zerorpc.invoke "test", "args", (err, res, more) ->
    test.equal err?, false
    test.equal true, res?
    test.equal false, more
    do test.done

module.exports = 

  setUp: (cb) =>
    
    # once server is bound and listening, bootup app
    @obj = 
      zerorpc: "tcp://127.0.0.1:4242"

    # create mock server object
    @server = new zpc.Server 
      test: (args, reply) ->
        reply null, "here"

    # bind server
    @server.bind "tcp://0.0.0.0:4242"
    cb?()

  tearDown: (cb) =>

    # shutdown app and clean up zerorpc server
    @app.close => 
      @server.close()
      cb?()

  testZerorpc: (test) =>

    appBootstrap @obj, (@app) =>
      clientTest @app, test

  paramSuite: 
  
    testString: (test) =>

      appBootstrap @obj, (@app) =>
        clientTest @app, test

    testObject: (test) =>
    
      appBootstrap {zerorpc: {host: "tcp://127.0.0.1:4242"}}, (@app) =>
        clientTest @app, test

