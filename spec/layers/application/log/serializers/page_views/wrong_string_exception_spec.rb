# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/serializers/page_views/wrong_string_exception'

RSpec.describe Application::Log::Serializers::PageViews::WrongStringException do
  subject { described_class.new(string) }
  let(:string) { '/mystr' }

  it 'forms message' do
    expect(subject.message).to eq "String \"#{string}\" is not correct"
  end

  it 'is expection' do
    is_expected.to be_a(StandardError)
  end
end
