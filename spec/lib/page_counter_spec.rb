# frozen_string_literal: true

require_relative '../spec_helper'

describe Parser::PageCounter do
  it 'returns blank array when no log present' do
    content = []
    expect(described_class.new(content).count).to be_empty
  end

  let(:content) do
    log_line = Parser::Parser::LogLine

    [
      log_line.new(page: 'help_page', ip_address: '126.318.035.038'),
      log_line.new(page: 'home', ip_address: '184.123.665.067'),
      log_line.new(page: 'help_page', ip_address: '126.318.035.038'),
      log_line.new(page: 'home', ip_address: '184.123.665.067'),
      log_line.new(page: 'help_page', ip_address: '102.318.035.038')
    ]
  end

  let(:page_counter) { described_class.new(content) }

  it 'counts the number of page view' do
    expect(page_counter.count).to match_array([
                                                { page: 'home', count: 2 },
                                                { page: 'help_page', count: 3 }
                                              ])
  end

  it 'counts return the number of unique page view' do
    expect(page_counter.count(unique_ip: true)).to match_array([
                                                                 { page: 'home', count: 1 },
                                                                 { page: 'help_page', count: 2 }
                                                               ])
  end
end
