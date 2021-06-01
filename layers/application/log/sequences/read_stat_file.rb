# frozen_string_literal: true

require 'layers/application/log/services/file_reader'
require 'layers/application/log/serializers/page_views/string'
require 'layers/domain/log/entities/stat'
require 'layers/domain/log/services/create_page_stat'
require 'layers/domain/log/commands/add_page_stat'

module Application
  module Log
    module Sequences
      class ReadStatFile
        def initialize(file_path, reader = Services::FileReader, serializer = Serializers::PageViews::String)
          @file_path = file_path
          @reader = reader
          @serializer = serializer
          @stat = Domain::Log::Entities::Stat.new({})
        end

        def call
          reader.call(file_path) do |line|
            page_view = serializer.new(line).call
            page_stat = Domain::Log::Services::CreatePageStat.call(page_view)
            Domain::Log::Commands::AddPageStat.new(stat, page_stat).call
          end

          stat
        end

        private

        attr_reader :file_path, :reader, :serializer, :stat
      end
    end
  end
end
