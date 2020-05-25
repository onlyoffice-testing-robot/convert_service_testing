# frozen_string_literal: true

class StaticData
  PROJECT_NAME = 'Convert Service Testing'
  TMP_DIR = "#{File.join(File.dirname(__FILE__), '/..')}/files_tmp"
  POSITIVE_STATUSES = %w[passed passed_2 pending].freeze
  PALLADIUM_SERVER = 'palladium.teamlab.info'
  JWT_ENABLE = ENV['USE_JWT'] != 'no'
  MIN_DOCX_IMAGE_SIZE = 5328
  MIN_PPTX_IMAGE_SIZE = 3300
  MIN_XLSX_IMAGES_SIZE = 5385

  TMP_FOLDER = 'files_tmp'

  def self.nginx_url
    ENV['NGINX'] || 'http://nginx'
  end

  def self.documentserver_url
    ENV['DOCUMENTSERVER'] || 'http://documentserver'
  end

  def self.get_jwt_key
    File.read("#{ENV['HOME']}/.documentserver/documentserver_jwt")
  end

  def self.jwt_data_exist?
    File.exist?("#{ENV['HOME']}/.documentserver/documentserver_jwt")
  end

  def self.get_palladium_token
    return ENV['PALLADIUM_TOKEN'] if ENV['PALLADIUM_TOKEN']

    File.read("#{ENV['HOME']}/.palladium/token")
  end
end
