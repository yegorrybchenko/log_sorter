# frozen_string_literal: true

require 'layers/domain/log/values/page_view'

module Application
  module Log
    module Serializers
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
            Domain::Log::Values::PageView.new(path, ip)
          end

          private

          attr_reader :string
        end
      end
    end
  end
end
