# frozen_string_literal: true

require '../spec_helper'

describe ImageHelper do
  it 'add a file smaller than 10 KB' do
    url_image = 'https://raw.githubusercontent.com/onlyoffice-testing-robot/convert_service_testing/feature/unit_test_image_helper/assets/4637.png'
    expect(ImageHelper.get_image_size(url_image.to_s)).to eq(4637)
  end

  it 'add a file larger than 10 KB' do
    url_image = 'https://raw.githubusercontent.com/onlyoffice-testing-robot/convert_service_testing/feature/unit_test_image_helper/assets/17129.png'
    expect(ImageHelper.get_image_size(url_image.to_s)).to eq(17_129)
  end
end
