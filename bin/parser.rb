#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/parser'

file_path = ARGV[0].strip

raise ArgumentError, 'Please provide a log file to parse' unless file_path

Parser::Parser.call(file_path)
