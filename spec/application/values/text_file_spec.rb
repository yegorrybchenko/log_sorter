# frozen_string_literal: true

require 'spec_helper'
require 'application/values/text_file'

RSpec.describe Application::Values::TextFile do
  context 'when file exist' do
    it 'creates new object' do
      expect { described_class.new('spec/files/webserver.log') }.not_to raise_exception
    end
  end
end
