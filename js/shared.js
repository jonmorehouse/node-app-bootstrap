// Generated by CoffeeScript 1.6.3
(function() {
  var _this = this;

  exports.missingParameters = function(keys, obj) {
    var key, missing;
    missing = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = keys.length; _i < _len; _i++) {
        key = keys[_i];
        if (obj[key] == null) {
          _results.push(key);
        }
      }
      return _results;
    })();
    if (missing.length > 0) {
      return missing;
    } else {
      return null;
    }
  };

}).call(this);