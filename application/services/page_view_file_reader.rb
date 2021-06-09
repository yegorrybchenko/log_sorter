# frozen_string_literal: true

module Application
  module Services
    class PageViewFileReader
      class << self
        def call(file, &block)
          file.each do |line|
            page_view = Deserializers::PageViews::String.new(line).call
            block.call(page_view)
          end
          file.close
        end
      end
    end
  end
end
