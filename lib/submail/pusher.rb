# encoding: utf-8

module Submail
  class Pusher
    attr_reader :host, :app_id, :signature

    def initialize(host, app_id, signature)
      @host = host
      @app_id = app_id
      @signature = signature
    end

    def message_xsend(to, project, vars = {}, links = {})
      xsend(:message, to, project, vars, links)
    end

    def mail_xsend(to, project, vars = {}, links = {})
      xsend(:mail, to, project, vars, links)
    end

    private

    def xsend(msg_type, to, project, vars, links)
      vars_json = JSON.dump(vars)
      links_json = JSON.dump(links)
      data = package_data({to: to, project: project, vars: vars_json, links: links_json})
      http_post(data, msg_type)
    end

    def package_data(args)
      data = { appid: app_id, signature: signature }
      data.merge(args)
    end

    def http_post(params, msg_type)
      http, uri = set_http_client(msg_type)

      req = Net::HTTP::Post.new(uri.path, initheader)
      req.body = params.to_json
      res = http.request(req)

      # FIXME: mail_xsend api 返回的 result 包含 UTF8 BOM
      #   "\xEF\xBB\xBF{\"status\":\"success\"}"
      #   需要在解析的时候处理掉 BOM 头，比较麻烦现在暂时不解析返回参数
      # JSON.parse(remove_utf8_bom(res.body), quirks_mode: true)
      res.body
    end

    def initheader
      {'Content-Type' => 'application/json'}
    end

    def remove_utf8_bom(text)
      text.gsub("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
    end

    def set_http_client(msg_type)
      path = case msg_type
        when :message
          'message/xsend.json'
        when :mail
          'mail/xsend.json'
        end
      uri = URI.parse(host + path)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      [http, uri]
    end

  end
end
