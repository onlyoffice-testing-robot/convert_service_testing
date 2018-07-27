# frozen_string_literal: true

class StaticData
  PROJECT_NAME = 'Convert Service Testing'
  DOCUMENTSERVER = 'https://doc-linux.teamlab.info'
  POSITIVE_STATUSES = %w[passed passed_2 pending].freeze

  PALLADIUM_SERVER = 'palladium.teamlab.info'
  JWT_ENABLE = true

  def self.get_jwt_key
    File.read("#{ENV['HOME']}/.documentserver/documentserver_jwt")
  end

  def self.jwt_data_exist?
    File.exist?("#{ENV['HOME']}/.documentserver/documentserver_jwt")
  end

  def self.get_palladium_token
    File.read("#{ENV['HOME']}/.palladium/token")
  end
end
