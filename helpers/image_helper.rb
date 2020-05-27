# frozen_string_literal: true

require 'open-uri'
require 'tempfile'
require_relative '../config/StaticData'

# Class for working with images after convert service
class ImageHelper
  def self.get_image_size(url)
    Tempfile.create('images-') do |fo|
      fo.binmode
      fo.write(URI.parse(url).open(&:read))
      File.size(fo.path)
    end
  end
end
