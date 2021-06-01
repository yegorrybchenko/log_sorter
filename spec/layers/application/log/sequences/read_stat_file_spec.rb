# frozen_string_literal: true

require 'spec_helper'
require 'layers/application/log/sequences/read_stat_file'

RSpec.describe Application::Log::Sequences::ReadStatFile do
  subject { described_class.new(file_path, reader, serializer_class).call }
  let(:reader) { double(:reader) }
  let(:serializer_class) { double(:serializer_class) }
  let(:serializer1) { double(:serializer1) }
  let(:serializer2) { double(:serializer2) }
  let(:string) { 'sring' }
  let(:string2) { 'sring2' }
  let(:page_view1) { Domain::Log::Values::PageView.new('path', 'ip') }
  let(:page_view2) { Domain::Log::Values::PageView.new('path2', 'ip2') }
  let(:page_stat1) { Domain::Log::Values::PageStat.new('path', ['ip']) }
  let(:page_stat2) { Domain::Log::Values::PageStat.new('path2', ['ip2']) }
  let(:file_path) { 'path_to_file' }

  before(:each) do
    allow(reader).to receive(:call).with(file_path).and_yield(string).and_yield(string2)

    allow(serializer_class).to receive(:new).with(string).and_return(serializer1)
    allow(serializer_class).to receive(:new).with(string2).and_return(serializer2)
    allow(serializer1).to receive(:call).and_return(page_view1)
    allow(serializer2).to receive(:call).and_return(page_view2)
  end

  it 'calls reader with file_path' do
    expect(reader).to receive(:call).with(file_path)

    subject
  end

  it 'calls serializer with returned strings' do
    expect(serializer_class).to receive(:new).with(string)
    expect(serializer_class).to receive(:new).with(string2)

    subject
  end

  it 'returns formed stats' do
    expected = {
      page_stat1.path => page_stat1,
      page_stat2.path => page_stat2
    }
    is_expected.to eq expected
  end
end
