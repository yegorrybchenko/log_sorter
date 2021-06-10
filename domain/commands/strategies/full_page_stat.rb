# frozen_string_literal: true

module Domain
  module Commands
    module Strategies
      class FullPageStat
        class << self
          def call(stat, full_page_stat)
            merge(stat, full_page_stat)
            stat
          end

          private

          def merge(stat, page_stat)
            existing_page_stat = stat[page_stat.path]
            return add_new(stat, page_stat) unless existing_page_stat

            fill_exising(existing_page_stat.ips, page_stat)
          end

          def add_new(stat, page_stat)
            stat[page_stat.path] = page_stat
            stat
          end

          def fill_exising(existing_ips, page_stat)
            page_stat.ips.each do |ip, count|
              existing_ips[ip] = existing_ips[ip].to_i + count
            end
          end
        end
      end
    end
  end
end
