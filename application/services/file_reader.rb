# frozen_string_literal: true

module Application
  module Services
    class FileReader
      class << self
        def call(file, &block)
          file.each(&block)
          file.close
        end
      end
    end
  end
end
