# frozen_string_literal: true

class SwaggerControllerTest < ActionDispatch::IntegrationTest
  test 'should get swagger ui' do
    get swagger_root_url
    assert_response :success
  end

  test 'should get swagger data [V1]' do
    get swagger_v1_data_url
    assert_response :success
  end

  test 'should get swagger data [V2]' do
    get swagger_v2_data_url
    assert_response :success
  end
end
