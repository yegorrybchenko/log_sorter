# frozen_string_literal: true

require 'spec_helper'
require 'application/services/file_reader'

RSpec.describe Application::Services::FileReader do
  subject { Application::Services::FileReader.call(file) { |l| l } }
  context 'when file exist' do
    context 'when file contains strings' do
      let(:text) { "first\nsecond\nlast\n" }
      let(:file) { StringIO.new(text) }

      it 'passes to block each string' do
        result = []
        Application::Services::FileReader.call(file) { |line| result << line }

        expect(result).to eq text.split(/(?<=\n)/)
      end

      it 'closes file' do
        expect(file).to receive(:close)
        subject
      end
    end
  end
end
