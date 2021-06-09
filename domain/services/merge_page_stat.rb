# frozen_string_literal: true

require 'domain/values/page_stat'

module Domain
  module Services
    class MergePageStat
      def initialize(first_page_stat, second_page_stat)
        @first_page_stat = first_page_stat
        @second_page_stat = second_page_stat
      end

      def call
        new_ips = first_page_stat.ips + second_page_stat.ips
        Values::PageStat.new(first_page_stat.path, new_ips)
      end

      private

      attr_reader :first_page_stat, :second_page_stat
    end
  end
end
