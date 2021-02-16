# frozen_string_literal: true

require 'ostruct'

module Parser
  # Parse the content to easily read the page and IP address
  class ContentParser
    attr_reader :content

    def initialize(content)
      @content = validate(content)
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

    private

    def validate(body)
      body.reject { |line| line.strip.empty? }.map(&:strip)
    end
  end
end
