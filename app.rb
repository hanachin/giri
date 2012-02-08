# -*- coding: utf-8 -*-
# Facebookページのいいね！ボタンが押されているかをSinatraで判定する
# http://d.hatena.ne.jp/ruedap/20110614/heroku_sinatra_facebook_page_tab_iine
require "sinatra"

helpers do
  def base64_url_decode str
    encoded_str = str.gsub("-","+").gsub("_","/")
    encoded_str += "=" while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end

  def decode_data str
    encoded_sig, payload = str.split(".")
    data = ActiveSupport::JSON.decode base64_url_decode(payload)
  end
end

get "/" do
  "POSTではない"
end

post "/" do
  signed_request = decode_data(params[:signed_request])

  return "タブページではない" unless signed_request["page"]

  if signed_request["page"]["liked"]
    "いいね！が押されてる"
  else
    "いいね！が押されてない"
  end
end
