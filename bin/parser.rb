#!/usr/bin/env ruby

require_relative '../lib/parser/log_file'
require_relative '../lib/parser/page_counter'
require_relative '../lib/parser'

content = Parser::LogFile.new('webserver.log').content
parsed_logs = Parser::Parser.new(content).parse
puts Parser::PageCounter.new(parsed_logs).count
