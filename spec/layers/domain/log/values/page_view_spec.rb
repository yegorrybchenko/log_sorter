# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/values/page_view'

RSpec.describe Domain::Log::Values::PageView do
  context 'when we create view' do
    let(:path) { 'page/1' }
    let(:ip) { '111.23.23.22' }
    let(:obj) { described_class.new(path, ip) }

    it 'creates successfully' do
      expect(obj.path).to eq path
      expect(obj.ip).to eq ip
    end

    context 'when we update view' do
      let(:path2) { 'page/2' }
      let(:ip2) { '111.53.43.22' }

      it 'updates successfully' do
        obj.path = path2
        obj.ip = ip2

        expect(obj.path).to eq path2
        expect(obj.ip).to eq ip2
      end
    end
  end
end
