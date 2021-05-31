# frozen_string_literal: true

module Domain
  module Log
    module Entities
      class PageStat
        attr_reader :path, :ips

        def initialize(path, ips)
          @path = path
          @ips = ips
        end
      end
    end
  end
end
