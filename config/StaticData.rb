# frozen_string_literal: true

class StaticData
  PROJECT_NAME = 'Convert Service Testing'
  POSITIVE_STATUSES = %w[passed passed_2 pending].freeze
  PALLADIUM_SERVER = 'palladium.teamlab.info'
  JWT_ENABLE = ENV['USE_JWT'] != 'no'
  MIN_DOCX_IMAGE_SIZE = 5327
  MIN_PPTX_IMAGE_SIZE = 1085
  MIN_XLSX_IMAGE_SIZE = 5384
  MIN_ODT_IMAGE_SIZE = 4636
  MIN_ODS_IMAGE_SIZE = 6021
  MIN_ODP_IMAGE_SIZE = 7788

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
