# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/entities/sorted_stat'

RSpec.describe Domain::Log::Entities::SortedStat do
  subject { described_class.new(stat) }
  let(:stat) { [build(:page_stat)] }

  context 'when we create sorted stat' do
    it 'creates successfully' do
      expect(subject.get).to eq stat
    end
  end
end
