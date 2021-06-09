# frozen_string_literal: true

require 'spec_helper'
require 'application/commands/print_stats'
require 'domain/values/collected_stat'

RSpec.describe Application::Commands::PrintStats do
  subject { described_class.call(collected_stats, out) }
  let(:out) { double(:out) }
  let(:collected_stats) { Domain::Values::CollectedStat.new(
    [['page/1', 2], ['page/33', 4]],
    [['page/f', 54], ['page12', 56]]
    ) }

  it 'puts each stat to out' do
    expect(out).to receive(:puts).with('Most viewed pages:')
    expect(out).to receive(:puts).with('page/1 has 2 view(s)')
    expect(out).to receive(:puts).with('page/33 has 4 view(s)')

    expect(out).to receive(:puts).with("\nPages with most unique views:")
    expect(out).to receive(:puts).with("page/f 54 unique view(s)")
    expect(out).to receive(:puts).with("page12 56 unique view(s)")
    subject
  end
end
