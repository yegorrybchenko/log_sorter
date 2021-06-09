# frozen_string_literal: true

require 'factory_bot'
require 'domain/values/full_page_stat'
require 'domain/values/page_view'

FactoryBot.define do
  factory :page_stat, class: Domain::Values::FullPageStat do
    initialize_with { new(path, ips) }

    path { 'page/cool/2' }
    ips { { '21.34.53.12' => 1 } }
  end
end

FactoryBot.define do
  factory :page_view, class: Domain::Values::PageView do
    initialize_with { new(path, ip) }

    path { 'page/cool/2' }
    ip { '21.34.53.12' }
  end
end
