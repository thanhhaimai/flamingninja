(function() {
  var GreenButton;

  GreenButton = require("../lib/sdk").GreenButton;

  module.exports = function(req, res) {
    var doRender;
    doRender = function(err, data) {
      var block, costs, divisor, multiplier, reading, timestamps, usage, _i, _j, _len, _len2, _ref, _ref2;
      if (err) {
        req.flash("error", err);
      } else if (data) {
        multiplier = data.usageSummary.powerOfTenMultiplier || 3;
        divisor = Math.pow(10, multiplier);
        timestamps = [];
        usage = [];
        costs = [];
        _ref = data.intervalBlock.intervalBlocks;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          block = _ref[_i];
          _ref2 = block.intervalReadings;
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            reading = _ref2[_j];
            timestamps.push(reading.timePeriod.start);
            usage.push(parseFloat(reading.value) / divisor);
            costs.push(reading.cost);
          }
        }
        data = JSON.stringify({
          chartCosts: costs,
          chartTimestamps: timestamps,
          chartUsage: usage,
          multiplier: multiplier
        });
      }
      return res.render("home", {
        data: data
      });
    };
    if (req.session.user) {
      return GreenButton(req).load(doRender);
    } else {
      return doRender();
    }
  };

}).call(this);
