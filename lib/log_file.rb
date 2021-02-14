# frozen_string_literal: true

class LogFile
  class FileNotFound < ArgumentError; end

  def initialize(path)
    raise(
      FileNotFound,
      'File path does not exists. Please check the file path.'
    ) unless File.exist?(path)
  end
end
