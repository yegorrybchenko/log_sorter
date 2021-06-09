# frozen_string_literal: true

module Application
  module Values
    class TextFile
      def initialize(file_path)
        @file = File.new(file_path)
      end
    end
  end
end
