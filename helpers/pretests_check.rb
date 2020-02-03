# frozen_string_literal: true

require 'net/http'
# class with methods for check working system before run tests
class PretestsCheck
  def self.pretests_check
    documentserver_check = documentserver_available?
    nginx_check = nginx_available?
    s3_check = s3_available?
    unless s3_check && documentserver_check && nginx_check
      puts "Documentserver check: #{s3_check}"
      puts "Nginx check: #{nginx_check}"
      puts "S3 check: #{s3_check}"
      raise 'Pre-test checks is failed!'
    end
    FileHelper.clear_dir('files_tmp')
  end

  def self.documentserver_available?
    OnlyofficeLoggerHelper.log('Check documentserver is available ' + StaticData.documentserver_url)
    status = request_to(StaticData.documentserver_url)

    OnlyofficeLoggerHelper.log("Documentserver on #{StaticData.documentserver_url} is unavailable") unless status
    status
  end

  def self.nginx_available?
    random_file_name = "#{Time.now.nsec}.txt"
    FileHelper.create_file("#{StaticData::TMP_FOLDER}/#{random_file_name}")
    status = request_to("#{StaticData.nginx_url}/#{random_file_name}")
    OnlyofficeLoggerHelper.log("Nginx server on #{StaticData.nginx_url} can not send files fom #{StaticData::TMP_FOLDER} folder") unless status
    status
  end

  def self.s3_available?
    s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new(bucket_name: 'conversion-testing-files', region: 'us-east-1')
    path = s3.download_file_by_name('docx/Doc8.docx', './files_tmp')
    File.file?(path) && File.size(path) > 1000
  end

  def self.request_to(path)
    url = URI.parse(path)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = if !url.path.empty?
             url.path
           else
             '/'
           end
    res = req.request_get(path)
    res.code != '404'
  rescue StandardError
    false
  end
end
