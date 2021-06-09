# frozen_string_literal: true

require 'spec_helper'
require 'application/commands/print_stats'

RSpec.describe Application::Commands::PrintStats do
  subject { described_class.call(stats, out) }
  let(:out) { double(:out) }
  let(:stats) { [page_stat1, page_stat2] }
  let(:page_stat1) { Domain::Values::PageStat.new('/page/2', %w[ip1 ip2]) }
  let(:page_stat2) { Domain::Values::PageStat.new('/page/3', ['ip3']) }

  it 'puts each stat to out' do
    expect(out).to receive(:puts).with('/page/2 2 unique view(s)')
    expect(out).to receive(:puts).with('/page/3 1 unique view(s)')

    subject
  end
end
