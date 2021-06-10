# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', File.dirname(__FILE__))

require 'application/sequences/print_file_stats'

file = File.new(ARGV[0])
Application::Sequences::PrintFileStats.call(file)
