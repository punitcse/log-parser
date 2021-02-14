# frozen_string_literal: true

module Parser
  # Parse the content to easily read the page and IP address
  class Counter
    attr_reader :logs

    def initialize(logs)
      @logs = logs
    end

    def count
      logs.group_by { |log| [log.page, log.count] }
    end
  end
end
