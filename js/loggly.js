// Generated by CoffeeScript 1.7.1
var c, loggly, shared,
  __slice = [].slice;

loggly = null;

c = require('multi-config');

shared = require("./shared");

exports.setUp = (function(_this) {
  return function(app, cb) {
    var cObj, client, lObj, missing;
    if (c.loggly == null) {
      app.log = function() {
        var args, msg;
        msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        cb = args[args.length - 1];
        return typeof cb === "function" ? cb() : void 0;
      };
      return typeof cb === "function" ? cb() : void 0;
    }
    if (loggly == null) {
      loggly = require('loggly');
    }
    missing = shared.missingParameters(["token", "subdomain", "username", "password", "tags"], c.loggly);
    if (missing) {
      return cb(new Error(missing));
    }
    cObj = c.loggly;
    lObj = {
      token: cObj.token,
      subdomain: cObj.subdomain,
      auth: {
        username: cObj.username,
        password: cObj.password
      },
      tags: cObj.tags != null ? cObj.tags : [],
      json: cObj.json != null ? cObj.json : true
    };
    client = loggly.createClient(lObj);
    app.loggly = client;
    app.log = function() {
      var args, msg, _ref;
      msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      return (_ref = this.loggly).log.apply(_ref, [msg].concat(__slice.call(args)));
    };
    return typeof cb === "function" ? cb() : void 0;
  };
})(this);

exports.tearDown = (function(_this) {
  return function(app, cb) {
    if (app.loggly != null) {
      delete app.loggly;
    }
    if (app.log != null) {
      delete app.log;
    }
    return typeof cb === "function" ? cb() : void 0;
  };
})(this);
