# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :view_count do
    view { association :page_view }
    count { 1 }
  end
end
