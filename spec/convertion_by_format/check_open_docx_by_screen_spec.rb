# frozen_string_literal: true

require 'spec_helper'
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert DOCX')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('docx')
describe 'Convert docx files by convert service' do
  (files - result_sets.map { |result_set| "docx/#{result_set}" }).each do |file_path|
    it File.basename(file_path) do
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=38299' if file_path == 'docx/ген_после_конвертирования_из_док.docx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=32793' if file_path == 'docx/Office Open XML Part 4 - Markup Language Reference.docx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=42324' if file_path == 'docx/SUMMER_APPLICATION_PG_1.docx'
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
