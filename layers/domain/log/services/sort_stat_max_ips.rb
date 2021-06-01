# frozen_string_literal: true

require 'layers/domain/log/entities/sorted_stat'

module Domain
  module Log
    module Services
      class SortStatMaxIps
        def initialize(stat)
          @stat = stat
        end

        def call
          hash = stat.get
          result = hash.values.sort do |first, second|
            second.ips.size <=> first.ips.size
          end
          Entities::SortedStat.new(result)
        end

        private

        attr_reader :stat
      end
    end
  end
end
