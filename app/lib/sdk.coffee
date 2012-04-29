require "date-utils"
{get, post, put, del} = require "./http"
moment = require "moment"

module.exports =

  User: (req) ->
  
    load: (options={}) -> get
      path: "/user/{user-id}"
      defaults:
        userId: "current-user"
      params: options.params
      auth: req.session.oauth
      next: getNext options

  UserAccount: (req) ->

    load: (options={}) -> get
      path: "/user/{user-id}/account/{account-id}"
      defaults:
        userId: "current-user"
        accountId: "default-account"
      params: options.params
      auth: req.session.oauth
      next: getNext options

  ListDevices: (req) ->

    load: (options={}) -> get
      path: "/user/{user-id}/account/{account-id}/location/{location-id}/network/default-network/device"
      defaults:
        userId: "current-user"
        accountId: "default-account"
        locationId: "default-location"
      params: options.params
      auth: req.session.oauth
      next: getNext options

  GetDeviceUsage: (req) ->

    load: (options={}) ->
      if not options.params["deviceId"]?
        console.log "warning: need to provide device id"
      format = "YYYY-MM-DDTHH:MM:SS"
      default_current_time = (new Date()).toFormat(format) + "+00:00"
      default_previous_time = (new Date()).addMonths(-1).toFormat(format) + "+00:00"
      default_resolution = "MONTHLY;from=#{default_previous_time};to=#{default_current_time}"
      console.log default_resolution
      get
        path: "/user/{user-id}/account/{account-id}/location/{location-id}/device/{device-id}/consumption/{resolution}"
        defaults:
          userId: "current-user"
          accountId: "default-account"
          locationId: "default-location"
          resolution: default_resolution
        params: options.params
        auth: req.session.oauth
        next: getNext options

  UserLocation: (req) ->

    load: (options={}) -> get
      path: "/user/{user-id}/account/{account-id}/location/{location-id}"
      defaults:
        userId: "current-user"
        accountId: "default-account"
        locationId: "default-location"
      params: options.params
      auth: req.session.oauth
      next: getNext options

  UserLocationProfile: (req) ->

    load: (options={}) -> get
      path: "/user/{user-id}/account/{account-id}/location/{location-id}/profile"
      defaults:
        userId: "current-user"
        accountId: "default-account"
        locationId: "default-location"
      params: options.params
      auth: req.session.oauth
      next: getNext options

  GreenButton: (req) ->
  
    load: (options={}) -> get
      path: "/greenbutton"
      query: ["resolution", "from", "to", "max-results"]
      defaults:
        resolution: "HOURLY"
        from: moment().subtract("weeks", 4).format("MM/DD/YYYY")
        to: moment().format("MM/DD/YYYY")
      params: options.params
      auth: req.session.oauth
      next: getNext options

getNext = (options) -> if typeof options is "function" then options else options.next
