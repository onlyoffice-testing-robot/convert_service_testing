# frozen_string_literal: true

require 'spec_helper'
FileHelper.clear_dir('files_tmp')
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert ODS')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('ods')
describe 'Convert ods files by convert service' do
  before do
    @image_size = nil
  end
  (files - result_sets.map { |result_set| "ods/#{result_set}" }).each do |file_path|
    it File.basename(file_path) do
      s3.download_file_by_name(file_path, './files_tmp')
      response = converter.perform_convert(url: file_uri(file_path), outputtype: 'png')
      expect(response[:url].nil?).to be_falsey
      expect(response[:url].empty?).to be_falsey
      @image_size = ImageHelper.get_image_size(response[:url])
      expect(@image_size).to be > StaticData::MIN_ODS_IMAGE_SIZE
    end
  end

  after :each do |example|
    FileHelper.clear_dir('files_tmp')
    palladium.add_result_and_log(example, @image_size)
  end
end
