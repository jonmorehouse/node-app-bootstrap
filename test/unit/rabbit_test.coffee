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
        name: "test"
        key: "testExchange"
        opts: {} # options to be passed to the amqp object on creation
      @obj.queue = 
        name: "test-queue"
        key: "testQueue"
        opts: {} # arr
      cb?()

    queueTest: (test) =>

      return do test.done
      bootstrap test, =>
        q = @app.rabbit[@obj.queue.key]
        e = @app.rabbit[@obj.exchange.key]
        ct = null
        test.equal true, q?
        test.equal true, q.subscribe?
        s = q.subscribe {ack:true}, (msg)=>
          # this should be called
          s.unsubscribe consumerTag
          do test.done
            
        p e
        e.publish "TEST"
        s.addCallback (ok) =>
          ct = ok.consumerTag
          q.on "basicQosOk", =>
            p "HERE"
          s.on "basicQosOk", =>
            p "HEASD"
            e.publish "msg"

    boundQueueTest: (test) =>

      # link up the exchange name accordingly here
      @obj.queue.exchange = @obj.exchange.name
      bootstrap test, =>

        do test.done

    queuesTest: (test) =>

      do test.done

    
