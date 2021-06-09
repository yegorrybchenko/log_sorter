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

            page_stat.ips.each do |ip, count|
              existing_page_stat.ips[ip] ||= 0
              existing_page_stat.ips[ip] = existing_page_stat.ips[ip] + count
            end
          end

          def add_new(stat, page_stat)
            stat[page_stat.path] = page_stat
            stat
          end
        end
      end
    end
  end
end
