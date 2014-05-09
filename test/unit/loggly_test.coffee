bootstrap = require "../bootstrap"
c = require 'node-config'
App = libRequire "app"

module.exports = 

  setUp: (cb) =>
    c.loadFromEnv ["LOGGLY_CUSTOMER_TOKEN", "LOGGLY_SUBDOMAIN", "LOGGLY_USERNAME", "LOGGLY_PASSWORD"]
    cb?()

  tearDown: (cb) =>

    cb?()

  logglyTest: (test) =>

    # basic 
    @obj =
      token: c.logglyCustomerToken
      subdomain: c.logglySubdomain
      username: c.logglyUsername
      password: c.logglyPassword
      tags: ["app-bootstrap-test"]

    appBootstrap {loggly: @obj}, (@app) =>

      p @app
      do test.done




