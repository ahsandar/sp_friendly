require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should create a block for user" do
    assert_difference('BlockList.count') do
      post '/api/v1/users/settings/block', params: {
        "requestor": "andy1234@example.com",
        "target": "john123@example.com"
        }, as: :json
      end

      assert_response 201
    end
end
