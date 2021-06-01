# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/sequences/read_stat_file'

RSpec.describe Application::Log::Sequences::ReadStatFile do
  subject { described_class.new(file_path, reader, serializer).call }
  let(:reader) { double }
  let(:serializer) { double }
  let(:string) { 'sring' }
  let(:string2) { 'sring2' }
  let(:page_view) { Domain::Log::Values::PageView.new('path', 'ip') }
  let(:page_view2) { Domain::Log::Values::PageView.new('path2', 'ip2') }
  let(:page_stat1) { Domain::Log::Values::PageStat.new('path', ['ip']) }
  let(:page_stat2) { Domain::Log::Values::PageStat.new('path2', ['ip2']) }
  let(:file_path) { 'path_to_file' }

  before(:each) do
    allow(reader).to receive(:call).with(file_path) do |&block|
      block.call
      string
    end

    allow(serializer).to receive(:call).with(string).and_return(page_view)
    allow(serializer).to receive(:call).with(string2).and_return(page_view2)
  end

  it 'calls reader with file_path' do
    expect(reader).to receive(:call).with(file_path)
    expect(reader).to yield_with_no_args

    subject
  end

  it 'calls serializer with returned strings' do
    expect(serializer).to receive(:call).with(string)
    expect(serializer).to receive(:call).with(string2)

    subject
  end

  it 'returns formed stats' do
    expected = {
      page_stat1.path => page_stat1,
      page_stat2.path => page_stat2
    }
    expect(subject.get).to eq expected
  end
end
