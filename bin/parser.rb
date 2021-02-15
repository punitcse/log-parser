#!/usr/bin/env ruby

require_relative '../lib/parser/log_file'
require_relative '../lib/parser/page_counter'
require_relative '../lib/parser'

file_path = ARGV[0].strip

content = Parser::LogFile.new(file_path).content
parsed_logs = Parser::Parser.new(content).parse
counter = Parser::PageCounter.new(parsed_logs)

puts counter.count
puts '===========================unique views===================================='
puts counter.count(unique_ip: true)
