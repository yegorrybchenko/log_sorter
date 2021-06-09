# frozen_string_literal: true

require 'spec_helper'
require 'domain/commands/strategies/full_page_stat'
require 'domain/values/full_page_stat'

RSpec.describe Domain::Commands::Strategies::FullPageStat do
  subject { described_class.call(stat, page_stat) }
  let(:page_stat) { build(:page_stat) }

  context 'when stat is empty' do
    let(:stat) { {} }
    
    it 'adds new page stat to stat' do
      expected = {
        page_stat.path => page_stat
      }

      is_expected.to eq expected
    end
  end

  context 'when stat is not empty' do
    let(:stat) { { page_stat2.path => page_stat2 } }

    context 'and pathes are different' do
      let(:page_stat2) { build(:page_stat, path: 'new_path') }

      it 'adds new page stat to current' do
        expected = {
          page_stat.path => page_stat
        }.merge(stat)
        
        is_expected.to eq expected
      end
    end

    context 'when pathes are the same' do
      context 'and ips are different' do
        let(:new_ip) { '22.47.41.35' }
        let(:page_stat2) { Domain::Values::FullPageStat.new(page_stat.path, [new_ip]) }

        it 'adds ip to stat' do
          expected_page_stat = Domain::Values::FullPageStat.new(page_stat2.path, page_stat.ips.keys << new_ip)
          
          have_ips = subject[page_stat.path].ips
          expect(have_ips).to eq expected_page_stat.ips
        end
      end

      context 'and ips are the same' do
        let(:page_stat2) { build(:page_stat) }

        it 'adds ip count to stat' do
          have_ips = subject[page_stat.path].ips
          expect(have_ips).to eq({ page_stat.ips.keys.first => 2 })
        end
      end
    end
  end
end
