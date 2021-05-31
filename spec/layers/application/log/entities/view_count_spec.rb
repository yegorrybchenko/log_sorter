# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/entities/view_count'

RSpec.describe Application::Log::Entities::ViewCount do
  subject { described_class.new(view) }

  context 'when we create view count' do
    let(:view) { build(:page_view) }

    it 'creates successfully' do
      expect(subject.view).to eq view
      expect(subject.count).to eq 1
    end
  end

  context 'when we increment view' do
    before(:each) do
      subject.increment
    end

    it 'changes count' do
      expect(subject.count).to eq 2
    end
  end
end
