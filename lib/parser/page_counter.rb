# frozen_string_literal: true

module Parser
  # Parse the content to easily read the page and IP address
  class PageCounter
    attr_reader :logs

    def initialize(logs)
      @logs = logs
    end

    def count(unique_ip: false)
      grouped_logs = logs.group_by(&:page)

      grouped_logs.map do |page, log|
        count = unique_ip ? log.uniq(&:ip_address).count : log.count
        { page: page, count: count }
      end
    end
  end
end
