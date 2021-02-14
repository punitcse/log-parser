# frozen_string_literal: true

require_relative '../spec_helper'

describe Parser::Counter do
  it 'counts the page view' do
    log_line = Parser::Parser::LogLine

    content = [
      log_line.new(page: 'help_page', ip_address: '126.318.035.038'),
      log_line.new(page: 'home', ip_address: '184.123.665.067'),
      log_line.new(page: 'help_page', ip_address: '126.318.035.038'),
      log_line.new(page: 'home', ip_address: '184.123.665.067'),
      log_line.new(page: 'help_page', ip_address: '102.318.035.038')
    ]
    expect(described_class.new(content).count).to eq([
      {page: 'home', count: 2},
      {page: 'help_page', count: 3}])
  end
end
