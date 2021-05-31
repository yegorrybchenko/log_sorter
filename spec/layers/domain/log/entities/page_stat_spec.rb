# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/entities/page_stat'

RSpec.describe Domain::Log::Entities::PageStat do
  subject { described_class.new(path, [ip]) }
  let(:path) { 'page/1' }
  let(:ip) { '111.23.23.22' }

  context 'when we create view count' do
    it 'creates successfully' do
      expect(subject.path).to eq path
      expect(subject.ips).to eq([ip])
    end
  end

  describe '#==' do
    let(:page_stat1) { described_class.new(path1, ips1) }
    let(:page_stat2) { described_class.new(path2, ips2) }

    context 'when pathes are equal' do
      let(:path1) { 'page/43' }
      let(:path2) { 'page/43' }

      context 'and ips are qeual' do
        let(:ips1) { [ip] }
        let(:ips2) { [ip] }

        it 'equals' do
          expect(page_stat1).to eq page_stat2
        end

        context 'and ips are not sorted' do
          let(:ip2) { '55.25.24.83' }
          let(:ips1) { [ip, ip2] }
          let(:ips2) { [ip2, ip] }

          it 'equals' do
            expect(page_stat1).to eq page_stat2
          end
        end
      end

      context 'and ips are not equal' do
        let(:ips1) { [ip] }
        let(:ips2) { [ip, '12.65.44.22'] }

        it 'does not equal' do
          expect(page_stat1).not_to eq page_stat2
        end
      end
    end

    context 'when pathes are not equal' do
      let(:path1) { 'page/43' }
      let(:path2) { 'page/44' }

      context 'and ips are qeual' do
        let(:ips1) { [ip] }
        let(:ips2) { [ip] }

        it 'does not equal' do
          expect(page_stat1).not_to eq page_stat2
        end
      end

      context 'and ips are not equal' do
        let(:ips1) { [ip] }
        let(:ips2) { [ip, '12.65.44.22'] }

        it 'does not equal' do
          expect(page_stat1).not_to eq page_stat2
        end
      end
    end
  end
end
