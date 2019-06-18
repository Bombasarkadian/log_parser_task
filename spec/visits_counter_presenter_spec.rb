# frozen_string_literal: true

require 'spec_helper'

RSpec.describe VisitsCounterPresenter do
  let(:visits) { [first_visit, second_visit, third_visit] }
  let(:first_visit) { instance_double('VisitsCounter', uri: '/first', visits_count: 2, unique_visits_count: 2) }
  let(:second_visit) { instance_double('VisitsCounter', uri: '/second', visits_count: 4, unique_visits_count: 1) }
  let(:third_visit) { instance_double('VisitsCounter', uri: '/third', visits_count: 3, unique_visits_count: 3) }

  describe '.initialize' do
    subject(:presenter) { described_class }

    it 'takes an array of visits as an argument' do
      expect { presenter.new(visits: []) }.not_to raise_error
    end
  end

  describe '#most_visitors' do
    subject(:most_visitors) { described_class.new(visits: visits).most_visitors }

    it 'returns array of visits ordered by visits_count' do
      expect(most_visitors).to eq(
        [
          "#{second_visit.uri} #{second_visit.visits_count}",
          "#{third_visit.uri} #{third_visit.visits_count}",
          "#{first_visit.uri} #{first_visit.visits_count}"
        ]
      )
    end
  end

  describe '#most_unique_visitors' do
    subject(:most_visitors) { described_class.new(visits: visits).most_unique_visitors }

    it 'returns array of visits ordered by unique_visits_count' do
      expect(most_visitors).to eq(
        [
          "#{third_visit.uri} #{third_visit.unique_visits_count}",
          "#{first_visit.uri} #{first_visit.unique_visits_count}",
          "#{second_visit.uri} #{second_visit.unique_visits_count}"
        ]
      )
    end
  end
end
