# frozen_string_literal: true

module Domain
  module Log
    module Entities
      class PageStat
        attr_reader :path, :ips

        def initialize(path, ips)
          @path = path
          @ips = Set.new(ips)
        end

        def ==(other)
          path == other.path &&
            ips == other.ips
        end
      end
    end
  end
end
