# frozen_string_literal: true

require 'open-uri'
require_relative '../config/StaticData'

# Class for working with images after convert service
class ImageHelper
  def self.get_image_size(url)
    temp_file = Tempfile.new('images-', StaticData::TMP_FOLDER.to_s, encoding: 'ascii-8bit')
    temp_file.write URI.parse(url).open.read
    temp_file.size
  end
end
