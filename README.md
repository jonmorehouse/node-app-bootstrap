# Node AppStrap
>  An easy way to bootstrap your project's external resources via conventional configuration

## Use Cases

This module is useful for starting web servers, distributed task consumers and small projects which use one, or some of the following,

* postgresql
* rabbit
* loggly
* redis

and should be run in a daemonized manner allowing for easy startup / shutdown

## Example 

~~~ coffee-script
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

~~~


