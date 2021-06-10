# frozen_string_literal: true

require 'domain/values/collected_stat'
require 'domain/services/full_page_stat_collector'

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
          collected = FullPageStatCollector.new(full_page_stat)
          total_views << collected.total
          unique_views << collected.unique
        end

        Values::CollectedStat.new(
          total_views,
          unique_views
        )
      end

      private

      attr_reader :stats, :total_views, :unique_views
    end
  end
end
