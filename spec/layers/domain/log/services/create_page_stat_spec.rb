# frozen_string_literal: true

require 'spec_helper'
require 'layers/domain/log/services/create_page_stat'

RSpec.describe Domain::Log::Services::CreatePageStat do
  subject { described_class.new(page_view).call }
  let(:page_view) { build(:page_view) }

  it 'creates page view' do
    expect(subject.path).to eq page_view.path
    expect(subject.ips).to eq Set.new([page_view.ip])
  end
end
