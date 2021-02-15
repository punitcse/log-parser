# frozen_string_literal: true
require 'ostruct'

module Parser
  # Parse the content to easily read the page and IP address
  class Parser
    attr_reader :content

    class LogLine < OpenStruct; end

    def initialize(content)
      @content = content
    end

    def parse
      logs = []

      content.each do |line|
        page, ip_address = line.split
        logs << LogLine.new(page: page, ip_address: ip_address)
      end
      logs
    end
  end
end
