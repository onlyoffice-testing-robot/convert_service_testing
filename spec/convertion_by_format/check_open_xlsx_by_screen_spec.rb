require 'spec_helper'
s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new
palladium = PalladiumHelper.new(DocumentServerHelper.get_version, 'Convert XLSX')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('xlsx')
describe 'Convert docx files by convert service' do
  (files - result_sets.map { |result_set| "xlsx/#{result_set}" }).each do |file_path|
    it File.basename(file_path) do
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=37463' if file_path == 'xlsx/-10.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=37461' if file_path == 'xlsx/tendencia.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=29881' if file_path == 'xlsx/сравнение формул.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=38603' if file_path == 'xlsx/test-workbook_tablestyleinfo.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=38605' if file_path == 'xlsx/printCrash.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=38488' if file_path == 'xlsx/Smaller50MB.xlsx'
      pending 'Timeout error' if file_path == 'xlsx/Mo drinks.xlsx'
      pending 'Timeout error' if file_path == 'xlsx/MODELO_planilhaControleFinanceiro.xlsx'
      pending 'Timeout error' if file_path == 'xlsx/70000strings.xlsx'
      pending 'Timeout error' if file_path == 'xlsx/50000strings.xlsx'
      pending 'https://bugzilla.onlyoffice.com/show_bug.cgi?id=39343' if file_path == 'xlsx/draw_00_ms2013.xlsx'
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
