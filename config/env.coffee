module.exports =
  app:
    trace: true
    secret: "test"
  oauth:
    trace: false
    consumer:
      url: "http://localhost:{port}"
      id: "841d607aa4781043cae95a2eb1661d3c"
      secret:"0443a723767d02d2a57070cfe660e297"
      scope: "greenbutton"
      threshold: 60
      routes:
        connect: "/session/connect"
        connected: "/session/connected"
        disconnect: "/session/disconnect"
        disconnected: "/session/disconnected"
    provider:
      url: "https://dev.tendrilinc.com"
      authorize: "/oauth/authorize"
      accessToken: "/oauth/access_token"
      logout: "/oauth/logout"
      route: "sandbox"
