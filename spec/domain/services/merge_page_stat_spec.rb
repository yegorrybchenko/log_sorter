# frozen_string_literal: true

require 'spec_helper'
require 'domain/services/merge_page_stat'

RSpec.describe Domain::Log::Services::MergePageStat do
  subject { described_class.new(page_stat1, page_stat2).call }

  context 'when page stats have the same path' do
    let(:page_stat1) { build(:page_stat) }

    context 'and stats do not have similar ips' do
      let(:ip2) { '11.22.33.44' }
      let(:ip3) { '22.32.43.44' }
      let(:page_stat2) { build(:page_stat, ips: [ip2, ip3]) }

      it 'merges ips' do
        expected = Domain::Log::Values::PageStat.new(page_stat1.path, page_stat1.ips + [ip2, ip3])
        is_expected.to eq expected
      end
    end

    context 'and stats have similar ips' do
      let(:ip2) { '22.32.43.44' }
      let(:page_stat2) { build(:page_stat, ips: page_stat1.ips << ip2) }

      it 'merges ips' do
        expected = Domain::Log::Values::PageStat.new(page_stat1.path, page_stat1.ips + [ip2])
        is_expected.to eq expected
      end
    end
  end
end
