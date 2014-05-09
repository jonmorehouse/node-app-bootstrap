nodeunit = require 'nodeunit'
{spawn, exec} = require 'child_process'
{print} = require 'sys'
bootstrap = require './test/bootstrap'

runner = (commandString)->
  command = exec commandString
  command.stderr.on 'data', (data)->
    print data.toString()

task "test", "Run all tests", ->

  reporter = nodeunit.reporters.verbose
  reporter.run ["test/unit/loggly_test.coffee"]

task "lint", "Lint project", ->

  command = "find . -type f -path ./node_modules -prune -o -name \"*.coffee\" | xargs -I '{}' coffeescript_linter {}"
  runner command

task "build", "Build jslib", ->

  runner "coffee -c -o jslib lib"

