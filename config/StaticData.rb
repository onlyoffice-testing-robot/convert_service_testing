class StaticData
  PROJECT_NAME = 'Convert Service Testing'.freeze
  DOCUMENTSERVER = 'https://doc-linux.teamlab.info'.freeze
  POSITIVE_STATUSES = %w[passed passed_2 pending].freeze

  PALLADIUM_SERVER = 'palladium.teamlab.info'.freeze
  JWT_ENABLE = true

  def self.get_jwt_key
    File.read("#{ENV['HOME']}/.documentserver/documentserver_jwt")
  end

  def self.jwt_data_exist?
    File.exist?("#{ENV['HOME']}/.documentserver/documentserver_jwt")
  end

  def self.get_palladium_token
    if File.exist?("#{ENV['HOME']}/.palladium/token")
      File.read("#{ENV['HOME']}/.palladium/token")
    else
      ENV['PALLADIUM_TOKEN'].strip
    end
  end
end
