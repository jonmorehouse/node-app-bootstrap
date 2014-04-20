path = require 'path'
amqp = require 'amqp'
async = require 'async'
fs = require 'fs'
stream = require 'stream'

# print out all call stack errors - this helps a ton!
process.on 'uncaughtException', (err)->
  console.error err.stack

# initialize global variables for helping out with tests
global.baseDirectory = path.resolve path.join __dirname, ".."
global.p = console.log
global.libRequire = (_path)->
  return require path.join baseDirectory, "lib", _path



