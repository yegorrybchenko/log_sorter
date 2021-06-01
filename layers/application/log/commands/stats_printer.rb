# frozen_string_literal: true

module Application
  module Log
    module Commands
      class StatsPrinter
        class << self
          def call(stats, out = $stdout)
            stats.each do |stat|
              out.puts "#{stat.path} #{stat.ips.size} unique view(s)"
            end
          end
        end
      end
    end
  end
end
