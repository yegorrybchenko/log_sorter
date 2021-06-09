# frozen_string_literal: true

require 'application/services/page_view_file_reader'
require 'application/deserializers/page_views/string'
require 'domain/services/create_page_stat'
require 'domain/commands/add_page_stat'

module Application
  module Sequences
    class FileToStats
      def initialize(file)
        @file = file
        @stat = {}
      end

      def call
        Services::PageViewFileReader.call(file) do |page_view|
          page_stat = Domain::Services::CreatePageStat.call(page_view)
          Domain::Commands::AddPageStat.new(stat, page_stat).call
        end

        stat
      end

      private

      attr_reader :file, :stat
    end
  end
end
