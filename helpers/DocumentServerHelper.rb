class DocumentServerHelper

  def self.get_version
    self.get_version_from_sdk_all(StaticData::DOCUMENTSERVER + '/sdkjs/word/sdk-all.js')
  end

  def self.get_version_from_sdk_all(sdk_all_link)
    starting_lines = `curl --compressed -m 10 --insecure -r 0-300 #{sdk_all_link} 2>/dev/null`
    trimmed_lines = starting_lines[0..300]
    trimmed_lines[/(\w+.)?\w+.\w+\s\(build:.*\)/]
  end
end