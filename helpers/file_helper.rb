# frozen_string_literal: true

# class with methods for working with files
class FileHelper
  # delete all files and folders from dir
  def self.clear_dir(dir)
    FileUtils.rm_rf("#{dir}/.", secure: true)
  end
end
