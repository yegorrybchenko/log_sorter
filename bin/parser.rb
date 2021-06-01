# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', File.dirname(__FILE__))

require 'layers/application/log/sequences/read_stat_file'
require 'layers/domain/log/services/sort_stat_max_ips'
require 'layers/application/log/commands/stats_printer'

file = File.new(ARGV[0])
stat = Application::Log::Sequences::ReadStatFile.new(file).call
sorted_stat = Domain::Log::Services::SortStatMaxIps.new(stat).call
Application::Log::Commands::StatsPrinter.call(sorted_stat.get)
