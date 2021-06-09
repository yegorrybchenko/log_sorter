# frozen_string_literal: true

module Application
  module Log
    module Deserializers
      module PageViews
        class WrongStringException < StandardError
          def initialize(string)
            super("String \"#{string}\" is not correct")
          end
        end
      end
    end
  end
end
