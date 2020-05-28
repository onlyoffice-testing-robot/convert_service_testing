# frozen_string_literal: true

require 'palladium'
class PalladiumHelper
  def initialize(plan_name, run_name)
    @palladium = Palladium.new(host: StaticData::PALLADIUM_SERVER,
                               token: StaticData.get_palladium_token,
                               product: StaticData::PROJECT_NAME,
                               plan: plan_name,
                               run: run_name)
  end

  def get_result_set_link
    "http://#{@palladium.host}/product/"\
    "#{@palladium.product_id}/plan/"\
    "#{@palladium.plan_id}/run/"\
    "#{@palladium.run_id}/result_set/"\
    "#{@palladium.result_set_id}"
  end

  def add_result_and_log(example, data_file = nil)
    result = add_result(example, data_file)
    OnlyofficeLoggerHelper.log("Test is #{result['status']['name']}")
    OnlyofficeLoggerHelper.log(get_result_set_link)
  end

  def add_result(example, data_file = nil)
    name = example.metadata[:description]
    status, comment = get_status(example)
    if data_file
      comment = { "subdescriber": [{ "title": 'image size (byte)', "value": data_file }], "describer": [{ "title": 'comment', "value": comment }] }
    end
    @palladium.set_result(name: name, description: comment.to_json, status: status)
  end

  def get_result_sets(status)
    @palladium.get_result_sets(status).map { |set| set['name'] }
  end

  def get_status(example)
    exception = example.exception
    comment = ''
    return [:pending, example.metadata[:execution_result].pending_message] if example.pending

    # custom_fields = init_custom_fields(example)
    if exception.to_s.include?('got:') || exception.to_s.include?('expected:')
      result = :failed
      comment += "\n#{exception.to_s.gsub('got:', "got:\n").gsub('expected:', "expected:\n")}\n"
    elsif exception.to_s.include?('to return') || exception.to_s.include?('expected')
      result = :failed
      comment += "\n" + exception.to_s.gsub('to return ', "to return:\n").gsub(', got ', "\ngot:\n")
    elsif exception.nil?
      result = :passed
      comment += "\nOk"
    else
      result = :aborted
      comment += "\n" + exception.to_s
    end
    [result, comment]
  end
end
