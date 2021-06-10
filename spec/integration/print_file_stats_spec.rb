# frozen_string_literal: true

require 'spec_helper'
require 'application/sequences/print_file_stats'

RSpec.describe Application::Sequences::PrintFileStats do
  let(:out) { double }

  it 'puts required stats to out' do
    expect(out).to receive(:puts).with('Most viewed pages:')
    expect(out).to receive(:puts).with('/about/2 has 90 view(s)')
    expect(out).to receive(:puts).with('/contact has 89 view(s)')
    expect(out).to receive(:puts).with('/index has 82 view(s)')
    expect(out).to receive(:puts).with('/about has 81 view(s)')
    expect(out).to receive(:puts).with('/help_page/1 has 80 view(s)')
    expect(out).to receive(:puts).with('/home has 78 view(s)')

    expect(out).to receive(:puts).with("\nPages with most unique views:")
    expect(out).to receive(:puts).with('/help_page/1 23 unique view(s)')
    expect(out).to receive(:puts).with('/contact 23 unique view(s)')
    expect(out).to receive(:puts).with('/home 23 unique view(s)')
    expect(out).to receive(:puts).with('/index 23 unique view(s)')
    expect(out).to receive(:puts).with('/about/2 22 unique view(s)')
    expect(out).to receive(:puts).with('/about 21 unique view(s)')

    file = File.new('spec/files/webserver.log')
    described_class.call(file, out)
  end
end
