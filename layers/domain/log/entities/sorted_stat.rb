# frozen_string_literal: true

module Domain
  module Log
    module Entities
      class SortedStat
        def initialize(stat)
          @stat = stat
        end

        def get
          @stat
        end
      end
    end
  end
end
