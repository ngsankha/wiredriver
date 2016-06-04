require 'json'

include Wiredriver::Common
include Wiredriver::Common::Util
include Wiredriver::Common::Parser

module Wiredriver
  class Driver
    attr_reader :session_id

    def initialize(url, capabilities)
      @bridge = Bridge.new(url)
      @capabilities = capabilities
      request_body = JSON.generate({ "desiredCapabilities" => capabilities })
      status, response_body = send_request("start_session", request_body, {})
      parsed_response = parse(response_body)
      @session_id = parsed_response["sessionId"]
    end

    def open_url(url)
      request_body = JSON.generate({ "url" => url })
      status, response_body = send_request("open_url", request_body)
      parse(response_body)
      self
    end

    def quit
      status, response_body = send_request("quit_session")
      parse(response_body)
      nil
    end

    private
    def send_request(command, body = nil, params = { "sessionId" => @session_id })
      method, path = COMMANDS[command]
      @bridge.request method, build_url(path, params, @bridge.path), body
    end
  end
end
