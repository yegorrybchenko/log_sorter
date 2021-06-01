# frozen_string_literal: true

require 'layers/domain/log/services/merge_page_stat'

module Domain
  module Log
    module Commands
      class AddPageStat
        def initialize(stat, page_stat)
          @stat = stat
          @page_stat = page_stat
        end

        def call
          add_stat
          stat
        end

        private

        attr_reader :stat, :page_stat

        def add_stat
          hash = stat.get
          path_stat = hash[page_stat.path]
          return add_new(page_stat) unless path_stat

          merged_page_stat = Services::MergePageStat.new(path_stat, page_stat).call
          add_new(merged_page_stat)
        end

        def add_new(new_page_stat)
          hash = stat.get
          hash[new_page_stat.path] = new_page_stat
        end
      end
    end
  end
end
