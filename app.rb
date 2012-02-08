# -*- coding: utf-8 -*-
# Facebookページのいいね！ボタンが押されているかをSinatraで判定する
# http://d.hatena.ne.jp/ruedap/20110614/heroku_sinatra_facebook_page_tab_iine
require "sinatra"
require "json"
require "base64"

set :protection, :except => :frame_options
set :public_folder, File.dirname(__FILE__) + "/public"

helpers do
  def base64_url_decode str
    encoded_str = str.gsub("-","+").gsub("_","/")
    encoded_str += "=" while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end

  def decode_data str
    encoded_sig, payload = str.split(".")
    data = JSON.parse base64_url_decode(payload)
  end
end

get "/" do
  "POSTではない"
end

post "/" do
  signed_request = decode_data(params[:signed_request])

  return erb :index unless signed_request["page"]

  if signed_request["page"]["liked"]
    erb :index
  else
    "いいね！が押されてない"
  end
end
