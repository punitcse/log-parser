# frozen_string_literal: true

require_relative '../../spec_helper'

describe Parser::LogFile do
  describe '#initialize' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/files/test.log" }

    it 'throws an error when file not found' do
      expect do
        described_class.new('./file_not_exists.log')
      end.to raise_exception(
        described_class::FileNotFound,
        'File path does not exists. Please check the file path.'
      )
    end

    it 'throws an error when file is not correct format' do
      invalid_format_file_path = "#{RSPEC_ROOT}/fixtures/files/test.json"
      expect do
        described_class.new(invalid_format_file_path)
      end.to raise_exception(
        described_class::FileFormatIsInvalid,
        'File Format not allowed. Please try with a file with .log extension'
      )
    end

    it 'reads a file line by line when file is valid' do
      log_file = described_class.new(path)
      expect(log_file.content).to be_a(Array)
      expect(log_file.content.length).to eq(6)
    end

    it 'ensures that the file is closed' do
      file = instance_double(File)

      allow(File).to receive(:open).and_return(file)
      allow(file).to receive(:readlines)

      expect(file).to receive(:close)
      described_class.new(path)
    end
  end
end
