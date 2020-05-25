# frozen_string_literal: true

require 'open-uri'
require_relative '../config/StaticData'

# Class for working with images after convert service
class ImageHelper
  def self.save_image_by_link(url)
    static_dir = StaticData::TMP_DIR + "/#{Time.now.nsec}.png"
    File.open(static_dir, 'wb') do |fo|
      fo.write URI.parse(url).open.read
    end
    static_dir
  end

  def self.get_images_size(url)
    image_pass = ImageHelper.save_image_by_link(url)
    File.size?(image_pass)
  end
end
