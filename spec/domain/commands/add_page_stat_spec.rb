# frozen_string_literal: true

require 'spec_helper'
require 'domain/commands/add_page_stat'

RSpec.describe Domain::Commands::AddPageStat do
  class TestStrategy
    class << self
      def call(stat, page_stat)
        stat['test'] = page_stat
      end
    end
  end

  it 'uses strategy to to add stat' do
    stat = {}
    described_class.new(stat, 'test_value', TestStrategy).call

    expect(stat['test']).to eq 'test_value'
  end
end
