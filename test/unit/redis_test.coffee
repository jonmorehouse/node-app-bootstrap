bootstrap = require "../bootstrap"
c = require 'node-config'

module.exports = 

  setUp: (cb) =>  
  
    c.loadFromEnv ["REDIS_HOST", "REDIS_PORT"]
    @obj = 
      host: c.redisHost
      port: c.redisPort
    cb?()

  tearDown: (cb) =>

    @app.close =>
      cb?()

  redis: (test) =>

    appBootstrap {redis: @obj}, (@app) =>
      test.equals true, @app?
      test.equals true, @app.redis?
      do test.done

    

  


