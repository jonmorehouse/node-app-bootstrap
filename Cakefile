nodeunit = require 'nodeunit'
{spawn, exec} = require 'child_process'
{print} = require 'sys'
bootstrap = require './test/bootstrap'

runner = (commandString)->
  command = exec commandString
  command.stdout.on 'data', (data) ->
    print data.toString()
  command.stderr.on 'data', (data) ->
    print data.toString()

task "test", "Run current tests", ->

  reporter = nodeunit.reporters.verbose
  reporter.run ["test/unit/daemon_test.coffee"]

task "test-all", "Run all tests", ->

  runner "nodeunit test/unit/daemon_test.coffee"

task "lint", "Lint project", ->

  command = "find . -type f -path ./node_modules -prune -o -name \"*.coffee\" | xargs -I '{}' coffeescript_linter {}"
  runner command

task "build", "Build js library", ->

  runner "coffee -c -o js lib"

