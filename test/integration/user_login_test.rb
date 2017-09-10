require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "failed login (wrong password)" do
    post login_path, params: {
      username: "user1",
      password: "password2"
    }
    response_json = JSON.parse(response.body)
    assert_equal "fail", response_json["result"]
    assert_equal "password incorrect", response_json["error"]
  end

  test "failed login (wrong username)" do
    post login_path, params: {
      username: "user3",
      password: "password1"
    }
    response_json = JSON.parse(response.body)
    assert_equal "fail", response_json["result"]
    assert_equal "no such user", response_json["error"]
  end

  test "successful login" do
    post login_path, params: {
      username: "user1",
      password: "password1"
    }
    response_json = JSON.parse(response.body)
    assert_equal "success", response_json["result"]
  end

  test "logout" do
    post login_path, params: {
      username: "user1",
      password: "password1"
    }
    assert is_logged_in?
    delete login_path
    assert_not is_logged_in?
  end
end
