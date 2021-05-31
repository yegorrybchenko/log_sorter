# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/entities/stat'

RSpec.describe Domain::Log::Entities::Stat do
  subject { described_class.new({ path => page_stat }) }
  let(:page_stat) { build(:page_stat) }
  let(:path) { 'page/1' }

  context 'when we create stat' do
    it 'creates successfully' do
      expected = { path => page_stat }
      expect(subject.get).to eq expected
    end
  end

  context 'when we change inner stat' do
    let(:new_value) { 'test value' }
    before(:each) do
      subject.get[path] = new_value
    end

    it 'changes' do
      expect(subject.get).to eq({ path => new_value })
    end
  end
end
