# frozen_string_literal: true

module Domain
  module Log
    module Services
      class SortStatMaxIps
        def initialize(stats)
          @stats = stats
        end

        def call
          stats.sort do |first, second|
            second.ips.size <=> first.ips.size
          end
        end

        private

        attr_reader :stats
      end
    end
  end
end
