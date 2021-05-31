# frozen_string_literal: true

require 'factory_bot'
require 'layers/domain/log/values/page_stat'

FactoryBot.define do
  factory :page_stat, class: Domain::Log::Values::PageStat do
    initialize_with { new(path, ips) }

    path { 'page/cool/2' }
    ips { ['21.34.53.12'] }
  end
end
