# frozen_string_literal: true

require 'spec_helper'
require 'domain/values/page_stat'

RSpec.describe Domain::Values::PageStat do
  subject { described_class.new(path, [ip]) }
  let(:path) { 'page/1' }
  let(:ip) { '111.23.23.22' }

  context 'when we create view count' do
    it 'creates successfully' do
      expect(subject.path).to eq path
      expect(subject.ips).to eq({ ip => 1 })
    end
  end
end
