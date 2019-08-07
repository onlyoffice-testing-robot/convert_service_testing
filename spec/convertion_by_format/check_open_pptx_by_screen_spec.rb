require 'spec_helper'
s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert PPTX')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('pptx')
describe 'Convert docx files by convert service' do
  (files - result_sets.map { |result_set| "pptx/#{result_set}" }).each do |file_path|
    it File.basename(file_path) do
      skip 'File without patterns. In will be added by editors. Not converted and its true' if file_path == 'pptx/empty_slides_layouts.pptx'
      skip 'Timeout error. File is too big(92mb)' if file_path == 'pptx/TouhouProject.pptx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=42340' if file_path == 'pptx/Cerbai.pptx'
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
