# frozen_string_literal: true

require 'spec_helper'
require 'application/services/file_reader'
require 'application/deserializers/page_views/string'
require 'domain/values/page_view'

RSpec.describe Application::Services::PageViewFileReader do
  subject { described_class.call(file) { |l| l } }
  context 'when file exist' do
    context 'when file contains strings' do
      let(:text) { "first\nsecond\nlast\n" }
      let(:file) { StringIO.new(text) }
      let(:page_view) { Domain::Values::PageView.new('path', 123) }

      before(:each) do
        %w(first second last).each { |l| stub_string_deserializer(l, page_view) }
      end

      it 'passes to block page view string' do
        result = []
        described_class.call(file) { |page_view| result << page_view }

        result.each do |e|
          expect(e).to be_an_instance_of(Domain::Values::PageView)
        end
      end

      it 'closes file' do
        expect(file).to receive(:close)
        subject
      end

      def stub_string_deserializer(string, return_value)
        allow(Application::Deserializers::PageViews::String)
          .to receive_message_chain(:new, :call).with(string).with(no_args).and_return(return_value)
      end
    end
  end
end
