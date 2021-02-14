# frozen_string_literal: true

class LogFile
  VALID_FORMATS = %w[.log].freeze

  class FileNotFound < ArgumentError; end
  class FileFormatIsInvalid < ArgumentError; end
  attr_reader :content


  def initialize(path)
    @path = path
    validate!
    @content = File.readlines(path)
  end

  private

  attr_reader :path

  def validate!
    not_found_msg = 'File path does not exists. Please check the file path.'
    raise FileNotFound, not_found_msg unless File.exist?(path)

    format_not_allowed_msg = "File Format not allowed. Please try with a file with #{VALID_FORMATS.join} extension"
    raise FileFormatIsInvalid,  format_not_allowed_msg unless VALID_FORMATS.include?(File.extname(path))
  end
end
