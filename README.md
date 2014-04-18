Node Worker Bootstrap
=====================

An easy way to bootstrap worker's in a clustered environment.

Example
-------

```
config = require 'node-config'
bootstrap = require 'worker-bootstrap'

config.load ->

  # this will load the app up as needed
  # start loggers/error handlers
  # start daemon trigger / controller
  # start up databases
  # start up queues 
  # start up rabbit worker (ie: subscribe to queues)
  bootstrap (app)->

    # do anything else needed for your app to run
    app.registerQueueTask queue/name, routingKey, method
    app.registerQueueTask queue/name, routingKey, method

    app.rabbitWorker.on "data", (task)->

      # find correct queueWorker
      # pass task to queue
      method = workers[task.queueName]
      if not method?
        app.error new Error "Unregistered QueueName"
      else
        method app, task, cb (err)->
          rabbitWorker.submit 
    
    # app was triggered to be closed
    # ie: app.error stream called app.triggerClose
    app.on "close", (err)->

      app.close()

```


