# frozen_string_literal: true

require 'spec_helper'
require 'application/sequences/print_file_stats'
require 'application/sequences/file_to_stats'
require 'domain/services/stat_collector'
require 'domain/services/stat_count_sorter'
require 'application/commands/print_stats'

RSpec.describe Application::Sequences::PrintFileStats do
  let(:file) { double }
  let(:stats) { double }
  let(:stat_values) { double }
  let(:collected_stats) { double }
  let(:sorted_stats) { double }
  let(:print_out) { double }

  before(:each) do
    allow(stats).to receive(:values).and_return(stat_values)

    allow(Application::Sequences::FileToStats)
      .to receive_message_chain(:new, :call).with(file).with(no_args).and_return(stats)
    allow(Domain::Services::StatCollector)
      .to receive_message_chain(:new, :call).with(stat_values).with(no_args).and_return(collected_stats)
    allow(Domain::Services::StatCountSorter)
      .to receive(:call).with(collected_stats, desc: true).and_return(sorted_stats)
  end

  it 'returns sorted stats' do
    expect(Application::Commands::PrintStats).to receive(:call).with(sorted_stats, print_out)

    described_class.call(file, print_out)
  end
end
