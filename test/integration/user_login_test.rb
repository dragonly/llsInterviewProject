require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "failed login (wrong password)" do
    post login_path, params: { user: {
      username: "user1",
      password: "password2"
    }}
    response_json = JSON.parse(response.body)
    assert_equal response_json["result"], "fail"
    assert_equal response_json["error"], "password incorrect"
  end

  test "failed login (wrong username)" do
    post login_path, params: { user: {
      username: "user3",
      password: "password1"
    }}
    response_json = JSON.parse(response.body)
    assert_equal response_json["result"], "fail"
    assert_equal response_json["error"], "no such user"
  end

  test "successful login" do
    post login_path, params: { user: {
      username: "user1",
      password: "password1"
    }}
    response_json = JSON.parse(response.body)
    assert_equal response_json["result"], "success"
  end

  test "logout" do
    post login_path, params: { user: {
      username: "user1",
      password: "password1"
    }}
    assert is_logged_in?
    delete login_path
    assert_not is_logged_in?
  end
end
