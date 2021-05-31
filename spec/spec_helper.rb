# frozen_string_literal: true

require 'factory_bot'

$LOAD_PATH.unshift File.expand_path('..', File.dirname(__FILE__))

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
