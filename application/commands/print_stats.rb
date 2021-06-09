# frozen_string_literal: true

module Application
  module Commands
    class PrintStats
      class << self
        def call(collected_stats, out = $stdout)
          print_total(collected_stats.total_views, out)
          print_unique(collected_stats.unique_views, out)
        end

        private

        def print_total(total, out)
          out.puts 'Most viewed pages:'
          total.each do |stat|
            out.puts "#{stat[0]} has #{stat[1]} view(s)"
          end
        end

        def print_unique(unique, out)
          out.puts "\nPages with most unique views:"
          unique.each do |stat|
            out.puts "#{stat[0]} #{stat[1]} unique view(s)"
          end
        end
      end
    end
  end
end
