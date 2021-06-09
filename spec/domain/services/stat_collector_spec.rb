# frozen_string_literal: true

require 'spec_helper'
require 'domain/services/stat_collector'

RSpec.describe Domain::Services::StatCollector do
  subject { described_class.new(stat).call }

  context 'when stat is empty' do
    let(:stat) { [] }

    it 'returns empty array' do
      expect(subject.total_views).to be_empty
      expect(subject.unique_views).to be_empty
    end
  end

  context 'when stat is filled' do
    let(:page_stat1) { build(:page_stat) }
    let(:page_stat2) { Domain::Values::FullPageStat.new('page/2', ['44.31.31.54', '12.45.32.21', '11.54.12.54']) }
    let(:page_stat3) { Domain::Values::FullPageStat.new('page/3', ['44.31.31.54', '54.123.23.76']) }
    let(:page_stat4) { Domain::Values::FullPageStat.new('page/4', ['43.24.21.54', '46.77.12.65']) }
    let(:page_stat5) { Domain::Values::FullPageStat.new('page/5', ['44.31.31.54']) }
    let(:stat) { [page_stat1, page_stat2, page_stat3, page_stat4, page_stat5] }

    before(:each) do
      page_stat4.ips['43.24.21.54'] = 3
    end

    it 'returns total views' do
      result = subject.total_views
      expect(result).to include(['page/4', 4], ['page/2', 3], ['page/3', 2], ['page/cool/2', 1], ['page/5', 1])
    end

    it 'returns unique views' do
      result = subject.unique_views
      expect(result).to include(['page/2', 3], ['page/3', 2], ['page/4', 2], ['page/cool/2', 1], ['page/5', 1])
    end
  end
end
