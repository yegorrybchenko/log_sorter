# frozen_string_literal: true

module Domain
  module Log
    module Services
      class SortStatMaxIps
        def initialize(stat)
          @stat = stat
        end

        def call
          hash = stat.get
          result = hash.values.sort do |a, b|
            b.ips.size <=> a.ips.size
          end
          Entities::SortedStat.new(result)
        end

        private

        attr_reader :stat
      end
    end
  end
end
