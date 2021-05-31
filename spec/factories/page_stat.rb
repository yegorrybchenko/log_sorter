# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :page_stat, class: Domain::Log::Entities::PageStat do
    initialize_with { new(path, ips) }

    path { 'page/cool/2' }
    ips { ['21.34.53.12'] }
  end
end
