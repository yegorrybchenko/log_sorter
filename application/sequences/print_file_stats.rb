# frozen_string_literal: true

require 'application/sequences/file_to_stats'
require 'application/commands/print_stats'
require 'domain/services/stat_collector'
require 'domain/services/stat_count_sorter'

module Application
  module Sequences
    class PrintFileStats
      class << self
        def call(file, out)
          stats = FileToStats.new(file).call
          collected = Domain::Services::StatCollector.new(stats.values).call
          sorted = Domain::Services::StatCountSorter.call(collected, desc: true)
          Application::Commands::PrintStats.call(sorted, out)
        end
      end
    end
  end
end
