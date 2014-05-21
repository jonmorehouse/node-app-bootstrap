bootstrap = require "../bootstrap"
amqp = require 'amqp'
c = require 'multi-config'
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
    setUp: (cb) =>
      @obj.exchange =
        name: "test"
        key: "testExchange"
        opts: {confirm: true} # options object to be passed directly to amqp 
      cb?()

    exchangeTest: (test) =>
      bootstrap test, =>
        test.equal true, @app.rabbit[@obj.exchange.key]?
        do test.done

    exchangePublishTest: (test) =>
      bootstrap test, =>
        e = @app.rabbit[@obj.exchange.key] 
        e.publish "*", "msg", {}, (err) =>
          test.equal false, err
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
        name: "test-exchange"
        key: "testExchange"
      @obj.queue = 
        name: "test-queue"
        key: "testQueue"
        exchange: @obj.exchange.name
        opts: {} 
      cb?()

    queueTest: (test) =>
      bootstrap test, =>
        q = @app.rabbit[@obj.queue.key]
        e = @app.rabbit[@obj.exchange.key]
        ct = null
        msg = {key: "value"}
        test.equal true, q?
        test.equal true, q.subscribe?
        s = q.subscribe {ack:true}, (_msg) =>
          test.deepEqual _msg, msg
          do test.done
        # subscribe, wait for the queue to be ready, and then publish!
        s.addCallback (ok) =>
          ct = ok.consumerTag
          e.publish "*", msg

    queuesTest: (test) =>

      @obj.exchanges = [@obj.exchange,
        {
          name: "test-queue-2"
          key: "testQueue2"
          exchange: @obj.exchange.name
        }
      ]
      
      bootstrap test, =>
        for e in @obj.exchanges
          test.equal true, @app.rabbit[e.key]?
        do test.done


