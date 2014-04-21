path = require 'path'
amqp = require 'amqp'
async = require 'async'
fs = require 'fs'
stream = require 'stream'
config = require 'node-config'

# print out all call stack errors - this helps a ton!
process.on 'uncaughtException', (err) ->
  console.error err.stack

# initialize global variables for helping out with tests
global.baseDirectory = path.resolve path.join __dirname, ".."
global.p = console.log
global.libRequire = (_path) ->
  return require path.join baseDirectory, "lib", _path

setUp = 
  config: (cb) ->

    cb?()

tearDown = {}

runner = (methodObj, cb) ->
  async.waterfall (_function for key, _function of methodObj), (err) ->
    p err if err
    cb?()

module.exports = 

  setUp: (cb) ->
    runner setUp, cb
  tearDown: (cb) ->
    runner tearDown, cb

