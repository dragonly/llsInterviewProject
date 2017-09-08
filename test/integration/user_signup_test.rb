require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "failed signup" do
    assert_no_difference 'User.count' do
      post user_index_path, params: { user: {
        username: "test",
        password: "1234567"
      }}
    end
  end

  test "successful signup" do
    assert_difference 'User.count', 1 do
      post user_index_path, params: { user: {
        username: "test",
        password: "12345678"
      }}
    end
  end
end
