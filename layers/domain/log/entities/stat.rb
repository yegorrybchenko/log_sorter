# frozen_string_literal: true

module Domain
  module Log
    module Entities
      class Stat
        def initialize(hash_stat)
          @stat = hash_stat
        end

        def get
          @stat
        end
      end
    end
  end
end
