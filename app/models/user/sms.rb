require 'net/http'
require 'faraday'

class User::Sms

  class << self
    def send_message(mobile, project_id)
      conn = Faraday.new(:url => 'https://api.submail.cn')
      conn.post do |req|
        req.url '/message/xsend.json'
        req.headers['Content-Type'] = 'application/json'
        body = '{"appid":"10330", "signature": "1f1bc2a6b1689a7ee02695a1967d7322",
                 "vars":{"vars_content"},"project":"project_id", "to":"mobile"}'
        body = body.gsub("mobile","#{mobile}")
        body = body.gsub("project_id","#{project_id}")
        body = body.gsub("vars_content","#{vars_content}")
        puts body
        req.body = body
      end
    end
  end
end