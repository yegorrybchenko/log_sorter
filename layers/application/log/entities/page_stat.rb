# frozen_string_literal: true

module Application
  module Log
    module Entities
      class PageStat
        attr_reader :path, :ips

        def initialize(path, ip)
          @path = path
          @ips = [ip]
        end
      end
    end
  end
end
