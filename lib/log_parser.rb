# frozen_string_literal: true

require './lib/file_loader'
require './lib/visits_counter'

class LogParser
  URI_REGEXP = %r{(?<uri>[^ ]+)}.freeze
  IP_REGEXP = %r{(?<ip>(\d{1,3}\.){3}\d{1,3})}.freeze
  LINE_REGEXP = %r{#{URI_REGEXP} #{IP_REGEXP}}.freeze

  def initialize(logfile_path:)
    @logfile_path = logfile_path
    @visits_hash = Hash.new { |hash, key| hash[key] = VisitsCounter.new(uri: key) }
  end

  def visits
    @visits ||= parse
  end

  private

  attr_reader :logfile_path, :visits_hash

  def parse
    log_entries.each { |entry| save_visit(*extract_parts(entry)) }
    visits_hash.values
  end

  def extract_parts(line)
    line.match(LINE_REGEXP)[1..2]
  end

  def save_visit(uri, ip)
    visits_hash[uri].count(ip: ip)
  end

  def log_entries
    @log_entries ||= FileLoader.new(file_path: logfile_path).lines
  end
end
