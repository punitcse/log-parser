# frozen_string_literal: true

require_relative '../spec_helper'

describe LogFile do
  describe '#initialize' do
    it 'throws an error when file not found' do
      expect do
        described_class.new('./file_not_exists.log')
      end.to raise_exception(
        described_class::FileNotFound,
        'File path does not exists. Please check the file path.'
      )
    end

    it 'throws an error when file is not correct format' do
      path = "#{RSPEC_ROOT}/fixtures/files/test.json"
      expect do
        described_class.new(path)
      end.to raise_exception(
        described_class::FileFormatIsInvalid,
       'File Format not allowed. Please try with a file with .log extension'
      )
    end

    it 'reads a file line by line when file is valid' do
      path = "#{RSPEC_ROOT}/fixtures/files/test.log"
      log_file = described_class.new(path)
      expect(log_file.content).to be_a(Array)
    end
  end
end
