# frozen_string_literal: true

require 'set'

class VisitsCounter
  attr_reader :uri, :visits_count, :unique_visits_count

  def initialize(uri:)
    @uri = uri
    @ips = Set.new
    @visits_count = 0
    @unique_visits_count = 0
  end

  def count(ip:)
    count_unique_visit unless ips.include?(ip)
    count_visit
    ips.add(ip)
  end

  private

  attr_reader :ips

  def count_visit
    @visits_count += 1
  end

  def count_unique_visit
    @unique_visits_count += 1
  end
end
