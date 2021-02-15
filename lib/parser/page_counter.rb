# frozen_string_literal: true

module Parser
  # Parse the content to easily read the page and IP address
  class PageCounter
    attr_reader :logs

    def initialize(logs)
      @logs = logs
    end

    def count(unique_ip: false)
      logs.map do |page, ip_addrs|
        count = unique_ip ? ip_addrs.values.size : ip_addrs.values.sum { |ip| ip[:count] }
        { page: page, count: count }
      end
    end
  end
end
