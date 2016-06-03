require 'uri'

module Wiredriver
  module Common
    class Bridge

      attr_reader :scheme, :host, :port, :userinfo, :path

      def initialize(url)
        @url = url.to_s
        parsed_uri = URI::parse(@url)

        if parsed_uri.class == URI::HTTP
          @scheme = :http
        elsif parsed_uri.class == URI::HTTPS
          @scheme = :https
        else
          raise Wiredriver::Error::BridgeError.new("Malformed URL cannot be parsed")
        end
        @host = parsed_uri.host
        @port = parsed_uri.port
        @userinfo = parsed_uri.userinfo
        @path = parsed_uri.path
      end
    end
  end
end
