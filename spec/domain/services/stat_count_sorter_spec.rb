# frozen_string_literal: true

require 'spec_helper'
require 'domain/services/stat_count_sorter'
require 'domain/values/collected_stat'

RSpec.describe Domain::Services::StatCountSorter do
  let(:collected_stat) { Domain::Values::CollectedStat.new(
    [['page/3', 2], ['page/4', 4], ['page/cool/2', 1], ['page/2', 3], ['page/5', 1]],
    [['page/cool/2', 1], ['page/3', 2], ['page/4', 2], ['page/5', 1], ['page/2', 3]]
  ) }
  
  context 'when direction is asc' do
    subject { described_class.call(collected_stat) }

    it 'returns ordered total views' do
      result = subject.total_views
      expect(result[0..1]).to include(['page/cool/2', 1], ['page/5', 1])
      expect(result[2]).to eq ['page/3', 2]
      expect(result[3]).to eq ['page/2', 3]
      expect(result[4]).to eq ['page/4', 4]
    end

    it 'returns orderes unique views' do
      result = subject.unique_views
      expect(result[0..1]).to include(['page/cool/2', 1], ['page/5', 1])
      expect(result[2..3]).to include(['page/3', 2], ['page/4', 2])
      expect(result[4]).to eq ['page/2', 3]
    end
  end
  
  context 'when direction is desc' do
    subject { described_class.call(collected_stat, desc: true) }

    it 'returns ordered total views' do
      result = subject.total_views
      expect(result[0]).to eq ['page/4', 4]
      expect(result[1]).to eq ['page/2', 3]
      expect(result[2]).to eq ['page/3', 2]
      expect(result[3..4]).to include(['page/cool/2', 1], ['page/5', 1])
    end

    it 'returns orderes unique views' do
      result = subject.unique_views
      expect(result[0]).to eq ['page/2', 3]
      expect(result[1..2]).to include(['page/3', 2], ['page/4', 2])
      expect(result[3..4]).to include(['page/cool/2', 1], ['page/5', 1])
    end
  end
end
