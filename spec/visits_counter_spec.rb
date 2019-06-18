# frozen_string_literal: true

require 'spec_helper'

RSpec.describe VisitsCounter do
  describe '.initialize' do
    subject(:counter) { described_class }

    it 'takes an uri as an argument' do
      expect { counter.new(uri: '/foo') }.not_to raise_error
    end
  end

  describe '#count' do
    subject(:counter) { described_class.new(uri: '/foo') }

    let(:first_ip) { '1.1.1.1' }
    let(:second_ip) { '1.1.1.2' }

    context 'when logging ip for the first time' do
      it 'updates visits count' do
        expect { counter.count(ip: first_ip) }.to change(counter, :visits_count).from(0).to(1)
      end

      it 'updates unique visits count' do
        expect { counter.count(ip: first_ip) }.to change(counter, :unique_visits_count).from(0).to(1)
      end
    end

    context 'when logging same ip for the second time' do
      before { counter.count(ip: first_ip) }

      it 'updates visits count' do
        expect { counter.count(ip: first_ip) }.to change(counter, :visits_count).from(1).to(2)
      end

      it 'does not update unique visits count' do
        expect { counter.count(ip: first_ip) }.not_to change(counter, :unique_visits_count).from(1)
      end
    end

    context 'when logging different ip' do
      before { counter.count(ip: first_ip) }

      it 'updates visits count' do
        expect { counter.count(ip: second_ip) }.to change(counter, :visits_count).from(1).to(2)
      end

      it 'updates unique visits count' do
        expect { counter.count(ip: second_ip) }.to change(counter, :unique_visits_count).from(1).to(2)
      end
    end
  end
end
