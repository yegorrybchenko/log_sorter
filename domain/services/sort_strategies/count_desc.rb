# frozen_string_literal: true

module Domain
  module Services
    module SortStrategies
      class CountDesc
        class << self
          def call(first, second)
            second.last <=> first.last
          end
        end
      end
    end
  end
end
