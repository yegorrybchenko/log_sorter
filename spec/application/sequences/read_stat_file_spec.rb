# frozen_string_literal: true

require 'spec_helper'
require 'application/sequences/read_stat_file'

RSpec.describe Application::Sequences::ReadStatFile do
  let(:serializer_class) { double(:serializer_class) }
  let(:file_path) { 'path_to_file' }
  let(:string) { 'string' }
  let(:string2) { 'string2' }
  let(:page_view1) { Domain::Values::PageView.new('path', 'ip') }
  let(:page_view2) { Domain::Values::PageView.new('path2', 'ip2') }

  it 'calls reader with file_path' do
    reader = define_reader(string, string2)
    define_serializer(serializer_class, string, page_view1)
    define_serializer(serializer_class, string2, page_view2)

    expect(reader).to receive(:call).with(file_path)

    described_class.new(file_path, reader, serializer_class).call
  end

  it 'returns formed stats' do
    reader = define_reader(string, string2)
    define_serializer(serializer_class, string, page_view1)
    define_serializer(serializer_class, string2, page_view2)

    page_stat1 = Domain::Values::PageStat.new('path', ['ip'])
    page_stat2 = Domain::Values::PageStat.new('path2', ['ip2'])

    expected = {
      page_stat1.path => page_stat1,
      page_stat2.path => page_stat2
    }

    result = described_class.new(file_path, reader, serializer_class).call
    expect(result).to eq expected
  end

  def define_reader(first_yield, second_yield)
    reader = double(:reader)
    allow(reader).to receive(:call).with(file_path).and_yield(first_yield).and_yield(second_yield)
    reader
  end

  def define_serializer(serializer_class, argument, return_value)
    serializer = double
    allow(serializer_class).to receive(:new).with(argument).and_return(serializer)
    allow(serializer).to receive(:call).and_return(return_value)
  end
end
