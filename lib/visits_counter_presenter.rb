# frozen_string_literal: true

require './lib/visits_counter'

class VisitsCounterPresenter
  def initialize(visits:)
    @visits = visits
  end

  def most_visitors
    @most_visitors ||= present(:visits_count)
  end

  def most_unique_visitors
    @most_unique_visitors ||= present(:unique_visits_count)
  end

  private

  attr_reader :visits

  def present(key)
    sorted_visits = visits.sort_by { |visit| visit.send(key) }.reverse
    sorted_visits.map { |visit| "#{visit.uri} #{visit.send(key)}" }
  end
end
