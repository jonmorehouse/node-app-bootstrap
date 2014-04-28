bootstrap = require "../bootstrap"
amqp = require 'amqp'
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
    @obj = 
      host: "localhost"
      port: 5672
    cb?()

  tearDown: (cb) =>
    if @app?
      @app.close =>
        cb?()
    else
      cb?()

  #connSuite:
    ## pass in credentials for a connection
    #objTest: (test) =>

      #bootstrap test, =>
        ## now make sure that the connection exists
        #test.notEqual false, @app.rabbit.conn?
        #do test.done

    ## pass in an already built out object
    #connObjTest: (test) =>

      #conn = amqp.createConnection {host: @obj.host, port: @obj.port}
      #conn.on "ready", =>
        #@obj.conn = conn
        ## bootstrap app with the connection now
        #bootstrap test, =>
          #do test.done

  exchangeSuite: 
    exchangeTest: (test) =>
      @obj.exchange =
        name: "test"
        key: "testExchange"
        opts: {} # options object to be passed directly to amqp 

      bootstrap test, =>
        do test.done

    exchangesTest: (test) =>
      @obj.exchanges = [
        { 
          name: "test"
          key: "testExchange"
          opts: {}
        },
        {
          name: "test1"
          key: "testExchange1"
          opts: {}
        }
      ]
      bootstrap test, =>
        for obj in @obj.exchanges
          test.notEqual false, @app.rabbit[obj.key]?
          test.notEqual false, 
        do test.done


  queueSuite: 
    
    setUp: (cb) =>
      # initailize objecst for testing this out
      @obj.exchange =
        name: "test"
        key: "testExchange"
        opts: {} # options to be passed to the amqp object on creation
      @obj.queue = 
        name: "test-queue"
        opts: {} # arr
      cb?()

    queueTest: (test) =>

    
      do test.done

    boundQueueTest: (test) =>

      do test.done

    queuesTest: (test) =>

      do test.done

    
