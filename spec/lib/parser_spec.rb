# frozen_string_literal: true

require_relative '../spec_helper'

describe Parser::Parser do
  describe '#parse' do
    it 'return logs with page name and ip address' do
      content = [
        '/help_page/1 126.318.035.038',
        '/home 184.123.665.067'
      ]
      logs = described_class.new(content).parse

      expect(logs.size).to eq(2)
      expect(logs).to match([
                              described_class::LogLine.new(page: 'help_page', ip_address: '126.318.035.038'),
                              described_class::LogLine.new(page: 'home', ip_address: '184.123.665.067')
                            ])
    end

    it 'does not return full URI for page name' do
      content = [
        '/otherpage/1/2/3/4 126.318.035.038'
      ]
      logs = described_class.new(content).parse

      expect(logs.size).to eq(1)
      expect(logs).to match([
                              described_class::LogLine.new(page: 'otherpage', ip_address: '126.318.035.038')
                            ])
    end

    it 'discard additional ip addresses in same line' do
      content = [
        '/home 184.123.665.067 184.123.665.067'
      ]
      logs = described_class.new(content).parse

      expect(logs.size).to eq(1)
      expect(logs).to match([
                              described_class::LogLine.new(page: 'home', ip_address: '184.123.665.067')
                            ])
    end
  end
end