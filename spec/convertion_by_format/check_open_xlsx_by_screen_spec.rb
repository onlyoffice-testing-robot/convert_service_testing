# frozen_string_literal: true

require 'spec_helper'
FileHelper.clear_dir('files_tmp')
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert XLSX')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('xlsx')
image_size = nil
describe 'Convert docx files by convert service' do
  before(:each) do
    @image_size = nil
  end
  (files - result_sets.map { |result_set| "xlsx/#{result_set}" }).each do |file_path|
    it File.basename(file_path) do
      skip 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=38488' if file_path == 'xlsx/Smaller50MB.xlsx'
      skip 'Timeout error' if file_path == 'xlsx/Consolidation_employees.xlsx'
      skip 'Timeout error' if file_path == 'xlsx/Mo drinks.xlsx'
      skip 'Timeout error' if file_path == 'xlsx/MODELO_planilhaControleFinanceiro.xlsx'
      skip 'Timeout error' if file_path == 'xlsx/70000strings.xlsx'
      skip 'Timeout error' if file_path == 'xlsx/50000strings.xlsx'
      skip 'Timeout error' if file_path == 'xlsx/Hasil Treasure 2010 Season 2.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=39491' if file_path == 'xlsx/Book 78.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=42327' if file_path == 'xlsx/05.2016_items.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=42334' if file_path == 'xlsx/_1-3-4-.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=42334' if file_path == 'xlsx/Customer_Engagement_Workbook_3_0_FY08_External.xlsx'
      s3.download_file_by_name('xlsx/' + File.basename(file_path), './files_tmp')
      response = converter.perform_convert(url: file_uri(file_path), outputtype: 'png')
      expect(response[:url].nil?).to be_falsey
      expect(response[:url].empty?).to be_falsey
      @image_size = ImageHelper.get_image_size(response[:url])
      expect(@image_size).to be > StaticData::MIN_XLSX_IMAGE_SIZE
    end
  end

  after :each do |example|
    FileHelper.clear_dir('files_tmp')
      palladium.add_result_and_log(example, @image_size)
  end
end
