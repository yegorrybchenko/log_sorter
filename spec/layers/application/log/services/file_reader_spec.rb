# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/services/file_reader'

RSpec.describe Application::Log::Services::FileReader do
  subject { Application::Log::Services::FileReader.call(file) { |l| } }
  context 'when file exist' do
    context 'when file contains strings' do
      let(:text) { "first\nsecond\nlast\n" }
      let(:file) { StringIO.new(text) }

      it 'passes to block each string' do
        result = []
        Application::Log::Services::FileReader.call(file) { |line| result << line }

        expect(result).to eq text.split(/(?<=\n)/)
      end

      it 'closes file' do
        allow(file).to receive(:close)

        subject

        expect(file).to receive(:close)
      end
    end
  end
end
