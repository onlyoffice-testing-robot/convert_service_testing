class StaticData
  PROJECT_NAME = 'Convert Service Testing'.freeze
  DOCUMENTSERVER = 'https://doc-linux.teamlab.info'.freeze
  POSITIVE_STATUSES = %w[passed passed_2 pending].freeze

  PALLADIUM_SERVER = 'palladium.teamlab.info'.freeze
  PALLADIUM_TOKEN = File.read("#{ENV['HOME']}/.palladium/token")

  DOCUMENTSERVER_JWT = File.read("#{ENV['HOME']}/.documentserver/documentserver_jwt")
end
