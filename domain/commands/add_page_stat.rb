# frozen_string_literal: true

require 'domain/commands/strategies/full_page_stat'

module Domain
  module Commands
    class AddPageStat
      def initialize(stat, page_stat, strategy = Strategies::FullPageStat)
        @stat = stat
        @page_stat = page_stat
        @strategy = strategy
      end

      def call
        strategy.call(stat, page_stat)
        stat
      end

      private

      attr_reader :stat, :page_stat, :strategy
    end
  end
end
