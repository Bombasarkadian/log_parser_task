#!/usr/bin/env ruby -w
# frozen_string_literal: true

require './lib/log_parser'
require './lib/visits_counter_presenter'

parser = LogParser.new(logfile_path: ARGV[0])
presenter = VisitsCounterPresenter.new(visits: parser.visits)

puts 'Most visited:'
puts presenter.most_visitors
puts
puts 'Most unique visitors:'
puts presenter.most_unique_visitors
