# frozen_string_literal: true

require 'spec_helper'
require 'application/deserializers/page_views/string'

RSpec.describe Application::Deserializers::PageViews::String do
  subject { described_class.new(string).call }

  context 'when string is correct' do
    let(:string) { '/about 126.318.035.038' }

    it 'creates page view' do
      page_vew = Domain::Values::PageView.new('/about', '126.318.035.038')
      is_expected.to eq page_vew
    end
  end

  context 'when string is not correct' do
    let(:exception) { Application::Deserializers::PageViews::WrongStringException }
    context 'when string has ending line symbol' do
      let(:string) { "/about 126.318.035.038\n" }

      it 'creates page view' do
        page_vew = Domain::Values::PageView.new('/about', '126.318.035.038')
        is_expected.to eq page_vew
      end
    end

    context 'when it does not have ip' do
      let(:string) { '/about' }

      it 'raises exception' do
        error = exception.new(string)
        expect { subject }.to raise_error(exception).with_message(error.message)
      end
    end

    context 'when it doe not have path' do
      let(:string) { ' 126.318.035.038' }

      it 'raises exception' do
        error = exception.new(string)
        expect { subject }.to raise_error(exception).with_message(error.message)
      end
    end
  end
end
