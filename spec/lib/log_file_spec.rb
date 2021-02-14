# frozen_string_literal: true

require_relative '../spec_helper'

describe LogFile do
  describe '#initialize' do
    it 'throws an error when file not found' do
      expect do
        LogFile.new('./file_not_exists.log')
      end.to raise_exception(
        LogFile::FileNotFound,
        'File path does not exists. Please check the file path.'
      )
    end
  end
end
