# frozen_string_literal: true

module Domain
  module Log
    module Values
      PageView = Struct.new(:path, :ip)
    end
  end
end
