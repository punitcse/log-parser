# frozen_string_literal: true

require 'ostruct'

module Parser
  # Parse the content to easily read the page and IP address
  class ContentParser
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def parse
      content.each_with_object({}) do |line, logs|
        page, ip_address = line.split

        if logs[page] && logs[page][ip_address]
          logs[page][ip_address][:count] += 1
        else
          logs[page] = {} if logs[page].nil?
          logs[page][ip_address] = { count: 1 }
        end
      end
    end
  end
end
