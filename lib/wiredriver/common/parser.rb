require 'json'

module Wiredriver
  module Common
    module Parser
      def parse(data)
        return JSON.parse data
      end
    end
  end
end
