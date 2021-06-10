# frozen_string_literal: true

module Domain
  module Services
    class FullPageStatCollector
      def initialize(full_page_stats)
        @full_page_stats = full_page_stats
      end

      def total
        [path, ips.values.inject(:+)]
      end

      def unique
        [path, ips.keys.size]
      end

      private

      attr_reader :full_page_stats

      def path
        full_page_stats.path
      end

      def ips
        full_page_stats.ips
      end
    end
  end
end
