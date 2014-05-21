c = require 'multi-config'


exports.setUp = (app, cb) =>

  p "START"

  cb?()

exports.tearDown = (app, cb) =>

  cb?()

