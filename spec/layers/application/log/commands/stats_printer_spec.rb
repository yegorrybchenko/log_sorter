# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/commands/stats_printer'

RSpec.describe Application::Log::Commands::StatsPrinter do
  subject { described_class.call(stats, out) }
  let(:out) { double(:out) }
  let(:stats) { [page_stat1, page_stat2] }
  let(:page_stat1) { Domain::Log::Entities::Stat.new('/page/2', %w[ip1 ip2]) }
  let(:page_stat2) { Domain::Log::Entities::Stat.new('/page/3', ['ip3']) }

  it 'puts each stat to out' do
    expect(out).to receive(:puts).with('/page/2 2 unique view(s)')
    expect(out).to receive(:puts).with('/page/3 1 unique view(s)')

    subject
  end
end
