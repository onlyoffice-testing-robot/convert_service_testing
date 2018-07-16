require 'spec_helper'
s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert PPTX')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
converter = OnlyofficeDocumentserverConversionHelper::ConvertFileData.new(StaticData::DOCUMENTSERVER, jwt_key: StaticData::DOCUMENTSERVER_JWT)

describe 'Convert docx files by convert service' do
  (s3.get_files_by_prefix('pptx') - result_sets).each do |file_path|
    it File.basename(file_path) do
      link = s3.get_object(file_path).presigned_url(:get, expires_in: 3600).split('?X-Amz-Algorithm')[0]
      response = converter.perform_convert(url: link, outputtype: 'png')
      expect(response[:url].nil?).to be_falsey
      expect(response[:url].empty?).to be_falsey
    end
  end

  after :each do |example|
    palladium.add_result_and_log(example)
  end
end
