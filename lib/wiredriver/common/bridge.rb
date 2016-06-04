require 'uri'
require 'curb'

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
        @curl = Curl::Easy.new
        if @userinfo
          username, password = @userinfo.split ":"
          @curl.http_auth_types = :basic
          @curl.username = username
          @curl.password = password
        end
        @curl.headers = { "Content-Type" => "application/json" }
        @curl.follow_location = true
      end

      def request(method, path, payload = nil)
        url_params = { :host => @host, :port => @port, :path => @path }
        if @scheme == :http
          current_url = URI::HTTP.build(url_params)
        else
          current_url = URI::HTTPS.build(url_params)
        end
        @curl.url = current_url
        @curl.post_body = payload unless payload.nil?
        @curl.http method.to_s.upcase
        return @curl.status.to_i, @curl.body_str
      end
    end
  end
end
