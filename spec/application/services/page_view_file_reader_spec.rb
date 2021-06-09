# frozen_string_literal: true

require 'spec_helper'
require 'application/services/file_reader'
require 'domain/values/page_view'

RSpec.describe Application::Services::PageViewFileReader do
  subject { described_class.call(file) { |l| l } }
  context 'when file exist' do
    context 'when file contains strings' do
      let(:text) { "first\nsecond\nlast\n" }
      let(:file) { StringIO.new(text) }

      it 'passes to block page view string' do
        result = []
        described_class.call(file) { |page_view| result << page_view }

        result.each do |e|
          exepct(e).to be_an_instance_of(Domain::Values::PageView)
        end
      end

      it 'closes file' do
        expect(file).to receive(:close)
        subject
      end
    end
  end
end
