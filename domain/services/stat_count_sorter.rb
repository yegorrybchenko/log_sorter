# frozen_string_literal: true

require 'domain/values/collected_stat'

module Domain
  module Services
    class StatCountSorter
      class << self
        def call(collected_stat, desc: false)
          total_views = sort_count(collected_stat.total_views, desc)
          unique_views = sort_count(collected_stat.unique_views, desc)

          Values::CollectedStat.new(total_views, unique_views)
        end

        private

        def sort_count(views, desc)
          views.sort do |first, second|
            desc ? second.last <=> first.last : first.last <=> second.last
          end
        end
      end
    end
  end
end
