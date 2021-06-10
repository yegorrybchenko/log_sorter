# frozen_string_literal: true

require 'spec_helper'
require 'application/sequences/file_to_stats'
require 'application/services/page_view_file_reader'
require 'domain/values/full_page_stat'

RSpec.describe Application::Sequences::FileToStats do
  subject { described_class.new(file).call }
  let(:serializer_class) { double(:serializer_class) }
  let(:file) { double }
  let(:string) { 'string' }
  let(:string2) { 'string2' }
  let(:page_view1) { Domain::Values::PageView.new('path', 'ip') }
  let(:page_view2) { Domain::Values::PageView.new('path2', 'ip2') }

  it 'calls reader with file' do
    reader = define_reader(page_view1, page_view2)
    expect(reader).to receive(:call).with(file)

    subject
  end

  it 'returns formed stats' do
    page_stat1 = Domain::Values::FullPageStat.new('path', ['ip'])
    page_stat2 = Domain::Values::FullPageStat.new('path2', ['ip2'])

    define_reader(page_view1, page_view2)

    expect(subject[page_stat1.path].path).to eq 'path'
    expect(subject[page_stat2.path].path).to eq 'path2'
    expect(subject[page_stat1.path].ips).to eq({ 'ip' => 1 })
    expect(subject[page_stat2.path].ips).to eq({ 'ip2' => 1 })
  end

  def define_reader(first_yield, second_yield)
    reader = Application::Services::PageViewFileReader
    allow(reader).to receive(:call).with(file).and_yield(first_yield).and_yield(second_yield)
    reader
  end
end
