{ListDevices, GetDeviceUsage} = require "../lib/sdk"

module.exports =

  list: (req, res) ->
  
    doRender = (err, data) ->
      console.log data
      console.log "here"
      if err
        req.flash "error", err
      else if data
        console.log data
      for deviceData in data["device"]
        deviceId = deviceData["deviceId"]
        console.log deviceId
      res.render "device/list", {data: data}
      
    if req.session.user
      ListDevices(req).load doRender
    else
      doRender()

  usage: (req, res) ->
  
    doRender = (err, data) ->
      console.log data
      console.log "here"
      if err
        req.flash "error", err
      else if data
        console.log data
      #for component in data["componentList"]["component0i#
      res.render "device/usage", {data: data}
      
    if req.session.user
      GetDeviceUsage(req).load
        params:
          deviceId: req.params.deviceId
        next: doRender
    else
      doRender()


