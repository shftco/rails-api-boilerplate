# frozen_string_literal: true

class SwaggerControllerTest < ActionDispatch::IntegrationTest
  test 'should get swagger ui' do
    get swagger_root_url
    assert_response :success
  end

  test 'should get swagger data' do
    get swagger_data_url
    assert_response :success
  end
end
