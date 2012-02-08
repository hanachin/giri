(function() {

  window.fbAsyncInit = function() {
    var appId, connected, login;
    appId = "245281592217300";
    FB.init({
      appId: appId,
      channelUrl: "//dl.dropbox.com/u/3622136/giri/channel.html",
      status: true,
      cookie: true,
      xfbml: true
    });
    login = function() {
      return FB.login(function(res) {
        console.log(res);
        if (res.status === "connected") return connected(res);
      }, {
        perms: "publish_stream"
      });
    };
    FB.getLoginStatus(function(res) {
      console.log(res);
      if (res.status === "connected") {
        console.log("connected.");
        return connected(res);
      } else if (res.status === "not_authorized") {
        console.log("not_authorized");
        return login();
      } else {
        console.log("signin してない");
        return login();
      }
    });
    return connected = function(res) {
      return FB.api('/me/permissions', function(res) {
        var imgUrl, _ref, _ref2;
        console.log(res);
        if ((_ref = res.data) != null ? (_ref2 = _ref[0]) != null ? _ref2.publish_stream : void 0 : void 0) {
          console.log("upload photo");
          imgUrl = "http://upload.wikimedia.org/wikipedia/commons/f/f2/Chocolate.jpg";
          return FB.api("/" + appId + "/photos", "post", {
            message: "義理チョコ診断",
            url: imgUrl
          }, function(res) {
            if (!(res != null) || res.error) {
              return alert("Error occured");
            } else {
              return console.log("Post ID: " + res.id);
            }
          });
        }
      });
    };
  };

  (function(d) {
    var id, js;
    js = void 0;
    id = "facebook-jssdk";
    if (d.getElementById(id)) return;
    js = d.createElement("script");
    js.id = id;
    js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    return d.getElementsByTagName("head")[0].appendChild(js);
  })(document);

}).call(this);
