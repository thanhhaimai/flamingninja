device = require "../app/controllers/device"

module.exports = (app) ->

  console.log device.list
  app.get "/", require "../app/controllers/home"
  app.get "/device/list", device.list
  app.get "/device/usage/:deviceId", device.usage
