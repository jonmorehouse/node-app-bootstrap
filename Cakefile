nodeunit = require 'nodeunit'
{spawn} = require 'child_process'
{print} = require 'sys'
bootstrap = require './test/bootstrap'

runner = (command)->

  command.stderr.on 'data', (data)->
    print data.toString()

  command.stdout.on 'data', (data)->
    print data.toString()

task "test", "Run all tests", ->

  reporter = nodeunit.reporters.verbose
  reporter.run ["test/unit"]

task "lint", "Lint project", ->

  runner spawn 'coffeelint', ['-r', 'lib']
  runner spawn 'coffeelint', ['-r', 'test']

task "build", "Build jslib", ->

  runner spawn 'coffee', ['-c', '-o', 'jslib', 'lib']

