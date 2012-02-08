window.fbAsyncInit = ->
  FB.init
    appId: "245281592217300"
    channelUrl: "//dl.dropbox.com/u/3622136/giri/channel.html"
    status: true
    cookie: true
    xfbml: true

  login = ->
    FB.login (res) ->
      console.log res
      if res.status is "connected"
        connected res
    , perms: "publish_stream"

  FB.getLoginStatus (res) ->
    console.log res
    if res.status is "connected"
      console.log "connected."
      connected res
    else if res.status is "not_authorized"
      console.log "not_authorized"
      login()
    else
      console.log "signin してない"
      login()

  connected = (res) ->
    console.log res.authResponse.signedRequest
    console.log parse_signed_request res.authResponse.signedRequest
    FB.api '/me/permissions', (res) ->
      console.log res
      if res.data?[0]?.publish_stream
        console.log "test"

((d) ->
  js = undefined
  id = "facebook-jssdk"
  return  if d.getElementById(id)
  js = d.createElement("script")
  js.id = id
  js.async = true
  js.src = "//connect.facebook.net/en_US/all.js"
  d.getElementsByTagName("head")[0].appendChild js
) document
