# frozen_string_literal: true

require 'domain/values/collected_stat'

module Domain
  module Services
    class StatCollector
      def initialize(full_page_stats)
        @stats = full_page_stats
        @total_views = []
        @unique_views = []
      end

      def call
        stats.each do |full_page_stat|
          total_views << [full_page_stat.path, total_page_views(full_page_stat.ips)]
          unique_views << [full_page_stat.path, unique_page_views(full_page_stat.ips)]
        end

        Values::CollectedStat.new(
          total_views,
          unique_views
        )
      end

      private

      attr_reader :stats, :total_views, :unique_views

      def total_page_views(page_ips)
        page_ips.values.inject(:+)
      end

      def unique_page_views(page_ips)
        page_ips.keys.size
      end
    end
  end
end
