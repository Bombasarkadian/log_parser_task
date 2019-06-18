# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FileLoader do
  describe '.initialize' do
    subject(:loader) { described_class }

    it 'takes a file path as an argument' do
      expect { loader.new(file_path: 'foo') }.not_to raise_error
    end
  end

  describe '#lines' do
    subject(:lines) { described_class.new(file_path: file_path).lines }

    let(:file_path) { './spec/fixtures/test.log' }

    context 'when file does not exist' do
      let(:file_path) { './spec/fixtures/missing_file.log' }

      it 'raises Error' do
        expect { lines.first }.to raise_error(Errno::ENOENT)
      end
    end

    context 'when file exists' do
      it { is_expected.to be_an(Enumerator) }
    end
  end
end
