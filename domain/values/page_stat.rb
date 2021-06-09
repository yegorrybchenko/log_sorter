# frozen_string_literal: true

module Domain
  module Values
    class PageStat
      attr_reader :path, :ips

      def initialize(path, ips)
        @path = path
        @ips = {}
        ips.each { |ip| @ips[ip] = 1 }
      end
    end
  end
end
