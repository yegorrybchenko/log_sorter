# frozen_string_literal: true

require 'domain/values/page_stat'

module Domain
  module Log
    module Services
      class CreatePageStat
        class << self
          def call(page_view)
            Values::PageStat.new(page_view.path, [page_view.ip])
          end
        end
      end
    end
  end
end
