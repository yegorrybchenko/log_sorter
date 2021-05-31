# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/commands/add_page_stat'

RSpec.describe Domain::Log::Commands::AddPageStat do
  subject { described_class.new(stat, page_stat).call }
  let(:page_stat) { build(:page_stat) }

  context 'when stat is empty' do
    let(:stat) { Domain::Log::Entities::Stat.new({}) }

    it 'adds new page stat to stat' do
      expected = {
        page_stat.path => page_stat
      }
      expect(subject.get).to eq expected
    end
  end

  context 'when stat is not empty' do
    let(:stat) { Domain::Log::Entities::Stat.new(stat_hash) }
    let(:stat_hash) { { page_stat2.path => page_stat2 } }

    context 'and pathes are different' do
      let(:page_stat2) { build(:page_stat, path: 'new_path') }

      it 'adds new page stat to current' do
        expected = {
          page_stat.path => page_stat
        }.merge(stat_hash)

        expect(subject.get).to eq expected
      end
    end

    context 'when pathes are the same' do
      let(:new_ip) { '22.47.41.35' }
      let(:page_stat2) { build(:page_stat, ips: [new_ip]) }

      it 'creates new page stat' do
        expected_page_stat = Domain::Log::Values::PageStat.new(page_stat2.path, page_stat.ips + page_stat2.ips)
        expected = {
          page_stat2.path => expected_page_stat
        }

        expect(subject.get).to eq expected
      end
    end
  end
end
