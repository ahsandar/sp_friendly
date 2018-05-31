require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friendship = friendships(:one)
  end

  test "should create friendship" do
    assert_difference('Friendship.count') do
      post '/api/v1/users/friendships', params:  {
        "friends":
        [
          "john1234@example.com",
          "johnny4567@example.com"
        ]
        } , as: :json
      end

      assert_response 201
    end


    test "should list empty friends for unavailable user" do
        post '/api/v1/users/friendships/list', params:  {
          "email": "abcd@example.com"
          } , as: :json

        assert_response 200
        response_body = JSON.parse response.body
        assert_equal 0, response_body['count']
      end

      test "should list no common friends  for unavailable user" do
          post '/api/v1/users/friendships/common', params:  {
            "friends":
            [
              "abcd@example.com",
              "johnny123@example.com"
            ]
            } , as: :json

          assert_response 200
          response_body = JSON.parse response.body
          assert_equal 0, response_body['count']
        end

        test "should respond with error for friends not being an Array" do
          post '/api/v1/users/friendships', params:  {
            "friends": "andy@example.com"
            } , as: :json

            assert_response 422
            response_body = JSON.parse response.body
            assert_equal 'friends need to be an Array', response_body['error']
          end

          test "should respond with error for friends Array size not equal to 2" do
            post '/api/v1/users/friendships', params:  {
              "friends":
              [
                "johnny4567@example.com"
              ]
              } , as: :json

              assert_response 422
              response_body = JSON.parse response.body
              assert_equal 'friends array requires 2 email Ids only', response_body['error']
            end

            test "should respond with error for friends Array having invalid email ID" do
              post '/api/v1/users/friendships', params:  {
                "friends":
                [
                  "john@example",
                  "johnny4567@example.com"
                ]
                } , as: :json

                assert_response 422
                response_body = JSON.parse response.body
                assert_equal 'Invalid Email', response_body['error']
              end



            end
