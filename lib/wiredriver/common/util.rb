require 'uri'

module Wiredriver
  module Common
    module Util
      def build_url(base_url, params = {}, prefix = "")
        params.each do |k, v|
          token = ":#{k.to_s}"
          base_url.gsub! token, v.to_s
        end
        URI.escape(prefix + base_url)
      end
    end
  end
end
