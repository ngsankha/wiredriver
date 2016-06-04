require 'json'

include Wiredriver::Common
include Wiredriver::Common::Util
include Wiredriver::Common::Parser

module Wiredriver
  class Driver
    attr_reader :session_id

    def initialize(url, capabilities)
      wire_spec = COMMANDS["start_session"]

      @bridge = Bridge.new(url)
      @capabilities = capabilities
      request_body = JSON.generate({ "desiredCapabilities" => capabilities })
      status, response_body = @bridge.request wire_spec[0], build_url(wire_spec[1], {}, @bridge.path), request_body
      parsed_response = parse(response_body)
      @session_id = parsed_response["sessionId"]
    end

    def open_url(url)
      wire_spec = COMMANDS["open_url"]

      request_body = JSON.generate({ "url" => url })
      status, response_body = @bridge.request wire_spec[0],
        build_url(wire_spec[1], { "sessionId" => @session_id }, @bridge.path), request_body
      parse(response_body)
      self
    end

    def quit
      wire_spec = COMMANDS["quit_session"]

      status, response_body = @bridge.request wire_spec[0],
        build_url(wire_spec[1], { "sessionId" => @session_id }, @bridge.path)
      parse(response_body)
      nil
    end
  end
end
