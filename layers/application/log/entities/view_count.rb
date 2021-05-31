# frozen_string_literal: true

module Application
  module Log
    module Entities
      class ViewCount
        INITIAL_COUNT = 1

        attr_reader :view, :count

        def initialize(view)
          @view = view
          @count = INITIAL_COUNT
        end

        def increment
          @count += count
        end
      end
    end
  end
end
