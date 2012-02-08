(function() {

  window.fbAsyncInit = function() {
    var connected, login;
    FB.init({
      appId: "245281592217300",
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
        var _ref, _ref2;
        console.log(res);
        if ((_ref = res.data) != null ? (_ref2 = _ref[0]) != null ? _ref2.publish_stream : void 0 : void 0) {
          return console.log("test");
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
