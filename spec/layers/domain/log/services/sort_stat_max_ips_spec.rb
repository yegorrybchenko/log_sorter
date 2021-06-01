# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/services/sort_stat_max_ips'

RSpec.describe Domain::Log::Services::SortStatMaxIps do
  subject { described_class.new(stat).call }

  context 'when stat is empty' do
    let(:stat) { [] }

    it 'returns empty array' do
      is_expected.to eq []
    end
  end

  context 'when stat is filled' do
    let(:page_stat1) { build(:page_stat) }
    let(:page_stat2) { build(:page_stat, path: 'page/2', ips: Set.new(['44.31.31.54', '12.45.32.21', '11.54.12.54'])) }
    let(:page_stat3) { build(:page_stat, path: 'page/3', ips: Set.new(['44.31.31.54', '54.123.23.76'])) }
    let(:page_stat4) { build(:page_stat, path: 'page/4', ips: Set.new(['43.24.21.54', '46.77.12.65'])) }
    let(:page_stat5) { build(:page_stat, path: 'page/5', ips: Set.new(['44.31.31.54'])) }
    let(:stat) { [page_stat1, page_stat2, page_stat3, page_stat4, page_stat5] }

    it 'returns ordered page stats' do
      result = subject
      expect(result[0]).to eq page_stat2
      expect(result[1..2]).to include(page_stat3, page_stat4)
      expect(result[3..4]).to include(page_stat1, page_stat5)
    end
  end
end
