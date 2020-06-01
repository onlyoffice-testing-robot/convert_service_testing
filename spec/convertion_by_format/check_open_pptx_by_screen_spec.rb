# frozen_string_literal: true

require 'spec_helper'
FileHelper.clear_dir('files_tmp')
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert PPTX')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('pptx')
data_file = nil
describe 'Convert docx files by convert service' do
  (files - result_sets.map { |result_set| "pptx/#{result_set}" }).each do |file_path|
    it File.basename(file_path) do
      skip 'File without patterns. In will be added by editors. Not converted and its true' if file_path == 'pptx/empty_slides_layouts.pptx'
      skip 'Timeout error. File is too big(92mb)' if file_path == 'pptx/TouhouProject.pptx'
      s3.download_file_by_name('pptx/' + File.basename(file_path), './files_tmp')
      link = "#{StaticData.nginx_url}/#{File.basename(file_path)}"
      uri = Addressable::URI.parse(link)
      response = converter.perform_convert(url: uri.normalize.to_s, outputtype: 'png')
      expect(response[:url].nil?).to be_falsey
      expect(response[:url].empty?).to be_falsey
      data_file = ImageHelper.get_image_size(response[:url])
      expect(data_file).to be > StaticData::MIN_DOCX_IMAGE_SIZE
    end
  end

  after :each do |example|
    FileHelper.clear_dir('files_tmp')
    palladium.add_result_and_log(example, data_file)
  end
end
