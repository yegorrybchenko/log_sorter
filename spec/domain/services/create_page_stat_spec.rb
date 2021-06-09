# frozen_string_literal: true

require 'spec_helper'
require 'domain/services/create_page_stat'

RSpec.describe Domain::Services::CreatePageStat do
  subject { described_class.call(page_view) }
  let(:page_view) { build(:page_view) }

  it 'creates page view' do
    expect(subject.path).to eq page_view.path
    expect(subject.ips).to eq Set.new([page_view.ip])
  end
end