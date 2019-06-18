# frozen_string_literal: true

# This class makes it easier to iterate over files
class FileLoader
  def initialize(file_path:)
    @file_path = file_path
  end

  def lines(&block)
    @lines ||= File.foreach(file_path, &block)
  end

  private

  attr_reader :file_path
end
