# frozen_string_literal: true

require 'ostruct'
require_relative 'parser/page_counter'
require_relative 'parser/view'
require_relative 'parser/log_file'
require_relative 'parser/version'

module Parser
  # Parse the content to easily read the page and IP address
  class Parser
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

    def self.call(file_path)
      logfile = LogFile.new(file_path)
      parsed_content = new(logfile.content).parse

      counter = PageCounter.new(parsed_content)

      page_counts = counter.count
      view = View.new
      view.render(page_counts)

      unique_page_counts = counter.count(unique_ip: true)
      view.render(unique_page_counts, unique: true)
    end
  end
end
