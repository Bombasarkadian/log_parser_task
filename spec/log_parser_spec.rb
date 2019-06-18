# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogParser do
  describe '.initialize' do
    subject(:parser) { described_class }

    it 'takes a logfile_path as an argument' do
      expect { parser.new(logfile_path: 'foo') }.not_to raise_error
    end
  end

  describe '#visits' do
    subject(:visits) { described_class.new(logfile_path: logfile_path).visits }

    let(:logfile_path) { './spec/fixtures/test.log' }

    context 'when logfile_path is invalid' do
      let(:logfile_path) { './spec/fixtures/missing_file.log' }

      it 'raises Error' do
        expect { visits }.to raise_error(Errno::ENOENT)
      end
    end

    it 'returns an array' do
      expect(visits).to be_an(Array)
    end

    it 'returns VisitsCounters' do
      expect(visits).to all be_a(VisitsCounter)
    end

    it 'has a VisitsCounter for every unique uri' do
      expect(visits.length).to eq(3)
    end
  end
end
