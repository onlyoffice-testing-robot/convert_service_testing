# frozen_string_literal: true

require 'open-uri'
require 'tempfile'
require_relative '../config/StaticData'

# Class for working with images after convert service
class ImageHelper
  # The method returns the file size taking url
  # @param url [String] url image
  # @return [Integer] size image
  def self.get_image_size(url)
    Tempfile.create('images-') do |tmpfile|
      binary_image = URI.open(URI.parse(url), 'r:binary').read
      tmpfile.binmode.write binary_image
      tmpfile.size
    end
  end
end
