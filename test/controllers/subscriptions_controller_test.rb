require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post '/api/v1/users/subscriptions', params: {
        "requestor": "andy1234@example.com",
        "target": "john123@example.com"
        }, as: :json
      end

      assert_response 201
    end

    test "should list subscription" do
        post '/api/v1/users/subscriptions/list', params: {
          "sender": "abcd@example.com",
          "text": "ahsan@live.com Hello World! kate@example.com"
          }, as: :json

        assert_response 200
        response_body = JSON.parse response.body
        assert_equal ["ahsan@live.com","kate@example.com"], response_body['recipients']
      end

      test "should respond with error for missing requestor" do
        post '/api/v1/users/subscriptions', params: {
          "target": "john123@example.com"
          }, as: :json

          assert_response 422
          response_body = JSON.parse response.body
          assert_equal 'Invalid or Missing requestor', response_body['error']
        end

        test "should respond with error for missing target" do
          post '/api/v1/users/subscriptions', params: {
            "requestor": "john123@example.com"
            }, as: :json

            assert_response 422
            response_body = JSON.parse response.body
            assert_equal 'Invalid or Missing target', response_body['error']
          end

          test "should respond with error for invalid requestor value" do
            post '/api/v1/users/subscriptions', params: {
              "requestor": "andy1234example.com",
              "target": "john123@example.com"
              }, as: :json

              assert_response 422
              response_body = JSON.parse response.body
              assert_equal 'Invalid or Missing requestor', response_body['error']
            end

            test "should respond with error for invalid target value" do
              post '/api/v1/users/subscriptions', params: {
                "requestor": "andy1234@example.com",
                "target": "john123example.com"
                }, as: :json

                assert_response 422
                response_body = JSON.parse response.body
                assert_equal 'Invalid or Missing target', response_body['error']
              end


            end
