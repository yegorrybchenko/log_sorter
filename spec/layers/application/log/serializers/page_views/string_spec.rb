# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/serializers/page_views/string'

RSpec.describe Application::Log::Serializers::PageViews::String do
  subject { described_class.new(string).call }

  context 'when string is correct' do
    let(:string) { '/about 126.318.035.038' }

    it 'creates page view' do
      page_vew = Domain::Log::Values::PageView.new('/about', '126.318.035.038')
      is_expected.to eq page_vew
    end
  end

  context 'when string is not correct' do
    context 'when string has ending line symbol' do
      let(:string) { '/about 126.318.035.038\n' }

      it 'creates page view' do
        page_vew = Domain::Log::Values::PageView.new('/about', '126.318.035.038')
        is_expected.to eq page_vew
      end
    end

    context 'when it does not have ip' do
      let(:string) { '/about' }

      it 'raises exception' do
        error = Application::Log::Serializers::PageViews::WrongStringException.new(string)
        expect { subject }.to raise_error(error)
      end
    end

    context 'when it doe not have path' do
      let(:string) { ' 126.318.035.038' }

      it 'raises exception' do
        error = Application::Log::Serializers::PageViews::WrongStringException.new(string)
        expect { subject }.to raise_error(error)
      end
    end
  end
end