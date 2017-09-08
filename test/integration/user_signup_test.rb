require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "failed signup" do
    assert_no_difference 'User.count' do
      post user_index_path, params: { user: {
        username: "test",
        password: "1234567"
      }}
      response_json = JSON.parse(response.body)
      assert_equal response_json["result"], "fail"
      assert_equal response_json["error"], ["Password is too short (minimum is 8 characters)"]
    end
  end

  test "successful signup" do
    assert_difference 'User.count', 1 do
      post user_index_path, params: { user: {
        username: "test",
        password: "12345678"
      }}
      response_json = JSON.parse(response.body)
      assert_equal response_json["result"], "success"
    end
  end
end
