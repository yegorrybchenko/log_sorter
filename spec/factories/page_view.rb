# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :page_view do
    path { 'page/cool/2' }
    ip { '21.34.53.12' }
  end
end
