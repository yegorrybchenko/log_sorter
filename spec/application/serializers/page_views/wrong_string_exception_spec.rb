# frozen_string_literal: true

require 'spec_helper'
require 'application/deserializers/page_views/wrong_string_exception'

RSpec.describe Application::Log::Deserializers::PageViews::WrongStringException do
  subject { described_class.new(string) }
  let(:string) { '/mystr' }

  it 'forms message' do
    expect(subject.message).to eq "String \"#{string}\" is not correct"
  end

  it 'is expection' do
    is_expected.to be_a(StandardError)
  end
end
