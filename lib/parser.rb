# frozen_string_literal: true

require_relative 'parser/log_file'
require_relative 'parser/page_counter'
require_relative 'parser/content_parser'
require_relative 'parser/view'

# Parser parse the file content and render the content in human readable format.
module Parser
  def self.call(file_path)
    logfile = LogFile.new(file_path)
    parsed_content = ContentParser.new(logfile.content).parse

    counter = PageCounter.new(parsed_content)

    page_counts = counter.count
    view = View.new
    view.render(page_counts)

    unique_page_counts = counter.count(unique_ip: true)
    view.render(unique_page_counts, unique: true)
  end
end
