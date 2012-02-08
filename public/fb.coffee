window.fbAsyncInit = ->
  appId = "245281592217300"
  FB.init
    appId: appId
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
    FB.api '/me/permissions', (res) ->
      console.log res
      if res.data?[0]?.publish_stream
        console.log "upload photo"
        imgUrl = "http://upload.wikimedia.org/wikipedia/commons/f/f2/Chocolate.jpg"
        FB.api("/#{appId}/photos", "post", {
          message: "義理チョコ診断"
          url: imgUrl
        }, (res) ->
          if not res? or res.error
            alert "Error occured"
          else
            console.log "Post ID: #{res.id}"
        )

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
