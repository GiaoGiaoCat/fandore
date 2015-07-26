require 'forwardable'
require 'net/https'
require 'uri'
require 'json'
require "submail/pusher"

# how to:
# pusher = Submail.pusher(APP_ID, SIGNATURE)
# pusher.message_xsend('13269259377', PROJECT, { sms_reg_code: '1234'})
# pusher.mail_xsend('wjp2013@gmail.com', PROJECT, { sms_reg_code: '1234'})

module Submail
  class << self
    extend Forwardable

    API_URL = "https://api.submail.cn/"

    attr_reader :pusher

    def_delegators :pusher, :message_xsend
    def_delegators :pusher, :mail_xsend

    def pusher(app_id, signature)
      @pusher = Submail::Pusher.new(API_URL, app_id, signature)
    end

  end
end
