nodeunit = require 'nodeunit'
{spawn, exec} = require 'child_process'
{print} = require 'sys'
try
  bootstrap = require './test/bootstrap'
catch
  bootstrap = null
  console.log "can't load test"

runner = (commandString)->
  command = exec commandString
  command.stdout.on 'data', (data) ->
    print data.toString()
  command.stderr.on 'data', (data) ->
    print data.toString()

task "test", "Run current tests", ->

  reporter = nodeunit.reporters.verbose
  reporter.run ['test/unit']

task "test-all", "Run all tests", ->

  runner "nodeunit test/unit"

task "lint", "Lint project", ->

  command = "find . -type f -path ./node_modules -prune -o -name \"*.coffee\" | xargs -I '{}' coffeescript_linter {}"
  runner command

task "build", "Build js library", ->

  runner "coffee -c -o js lib"

