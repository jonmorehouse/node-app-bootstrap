Node App Bootstrap
=====================

An easy way to bootstrap workers in a clustered environment. Allows you to sandbox your tasks with a single app runtime.

Thoughts
--------

* make this easily modular so I can create a similar project for an api worker in the future
* take out the rabbit runner - thats a huge dependency that will complicate this 
* it should be so simple to get up and running anyway ... it shouldn't be a huge deal
* this is only for external services and such!
* this application favors code stability / ease of development over speed. Therefore everything in startup will be async and will be run in series (this could result in a bit of a slower startup, but for now should hopefully be fine)

Goals
-----

* make environments easily managed
* easily reproducible for testing
* connect/disconnect of many different services is complicated. Unify under one module

Example 
-------

``` coffee-script
config = require 'node-config'
bootstrap = require 'worker-bootstrap'
rabbitWorker = require 'rabbitWorker'

config.load ->

  # this will load the app up as needed
  # start loggers/error handlers
  # start daemon trigger / controller
  # start up databases [psql, redis]
  # start up zerorpc connections 
  # start up rabbit connections, queues, exchanges
  # start up rabbit worker (ie: subscribe to queues)
  bootstrap (app)->

    # app.error "msg", fatal=false
    # app.log "msg", level=info

    # handle graceful shutdowns
    # ie: app.error stream called app.triggerClose
    app.on "close", (err)->

      rabbitWorker.close() -> handle all tasks accordingly
      app.close()

    ###
    ### Custom logic goes here
    ###
    # create rabbit worker
    rabbitWorker = new RabbitWorker app.queue, 2, ...
    rabbitWorker.on "data", (task)->

      # find correct queueWorker
      # pass task to queue
      method = workers[task.queueName]
      if not method?
        app.error new Error "Unregistered QueueName"
      else
        method app, task, cb (err)->
          rabbitWorker.submit 
```


