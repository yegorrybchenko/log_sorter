# frozen_string_literal: true

require 'domain/values/page_view'

module Application
  module Deserializers
    module PageViews
      class String
        REGEX = /(\S+)\s+(\S+)\s*/.freeze

        def initialize(string)
          @string = string
        end

        def call
          result = string.match(REGEX)
          raise WrongStringException, string unless result

          path = result[1]
          ip = result[2]
          Domain::Values::PageView.new(path, ip)
        end

        private

        attr_reader :string
      end
    end
  end
end
