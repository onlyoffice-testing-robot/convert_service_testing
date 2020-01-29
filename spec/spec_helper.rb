# frozen_string_literal: true

require 'bundler/setup'
require 'onlyoffice_s3_wrapper'
require 'onlyoffice_documentserver_conversion_helper'
require 'onlyoffice_logger_helper/logger_helper'
require_relative '../config/StaticData'
require_relative '../helpers/PalladiumHelper'
require_relative '../helpers/DocumentServerHelper'


def s3
  @s3 ||= OnlyofficeS3Wrapper::AmazonS3Wrapper.new(bucket_name: 'conversion-testing-files', region: 'us-east-1')
end

RSpec.configure do |config|
  def converter
    @converter ||= if !StaticData::JWT_ENABLE
                     OnlyofficeDocumentserverConversionHelper::ConvertFileData.new(StaticData::DOCUMENTSERVER)
                   elsif StaticData.jwt_data_exist?
                     OnlyofficeDocumentserverConversionHelper::ConvertFileData.new(StaticData::DOCUMENTSERVER, jwt_key: StaticData.get_jwt_key.strip)
                   end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
