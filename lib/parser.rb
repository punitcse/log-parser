# frozen_string_literal: true

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
        page_name, ip_address = line.split
        page =  validate_page_name(page_name)
        logs << LogLine.new(page: page, ip_address: ip_address)
      end
      logs
    end

    private

    def validate_page_name(name)
      name.delete_prefix('/').split('/').first
    end
  end
end
