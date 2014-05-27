// Generated by CoffeeScript 1.7.1
(function() {
  var c, shared, zerorpc;

  c = require('multi-config');

  zerorpc = require('zerorpc');

  shared = require("./shared");

  exports.setUp = function(app, cb) {
    var host, key, obj, opts, _i, _len, _ref;
    if (c.zerorpc == null) {
      return typeof cb === "function" ? cb() : void 0;
    }
    opts = c.zerorpc.opts != null ? c.zerorpc.opts : {};
    host = c.zerorpc.host != null ? c.zerorpc.host : "tcp://127.0.0.1:4242";
    obj = null;
    if (typeof c.zerorpc === "string") {
      host = c.zerorpc;
    } else if (typeof c.zerorpc === "object") {
      _ref = ["obj", "object", "context"];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        key = _ref[_i];
        if (key in c.zerorpc && (c.zerorpc[key] != null)) {
          obj = c.zerorpc[key];
        }
      }
    }
    if (obj == null) {
      app.zerorpcClient = zerorpc.Client(opts);
      app.zerorpcClient.connect;
    } else {
      app.zerorpcServer = zerorpc.Server;
    }
    return typeof cb === "function" ? cb() : void 0;
  };

  exports.tearDown = function(app, cb) {
    return typeof cb === "function" ? cb() : void 0;
  };

}).call(this);
