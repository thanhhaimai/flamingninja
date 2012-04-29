(function() {
  var User;

  User = require("../lib/sdk").User;

  exports.events = {
    connected: function(req, res) {
      return User(req).load(function(err, user) {
        if (err) {
          req.flash("error", "Unable to fetch user information after OAuth log in");
        } else {
          req.session.user = user;
        }
        return res.redirect("/", 303);
      });
    },
    disconnected: function(req, res) {
      return res.redirect("/", 303);
    },
    denied: function(err, req, res) {
      req.flash("error", err);
      return res.redirect("/", 303);
    },
    error: function(err, req, res) {
      req.flash("error", err);
      return res.redirect("/", 303);
    }
  };

}).call(this);
