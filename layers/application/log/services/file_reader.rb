# frozen_string_literal: true

module Application
  module Log
    module Services
      class FileReader
        class << self
          def call(file, &block)
            file.each(&block)
          end
        end
      end
    end
  end
end
