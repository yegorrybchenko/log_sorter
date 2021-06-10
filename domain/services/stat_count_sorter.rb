# frozen_string_literal: true

require 'domain/values/collected_stat'
require 'domain/services/sort_strategies/count_desc'

module Domain
  module Services
    class StatCountSorter
      class << self
        def call(collected_stat, strategy = SortStrategies::CountDesc)
          total_views = sort(collected_stat.total_views, strategy)
          unique_views = sort(collected_stat.unique_views, strategy)

          Values::CollectedStat.new(total_views, unique_views)
        end

        private

        def sort(views, strategy)
          views.sort do |first, second|
            strategy.call(first, second)
          end
        end
      end
    end
  end
end
