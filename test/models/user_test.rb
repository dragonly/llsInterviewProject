require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "user1", password: "password")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "password should be long enough" do
    user = User.new(username: "user", password:"weak")
    assert_not user.valid?
  end

  test "user password should be authenticated" do
    assert @user.authenticate("password")
    assert_not @user.authenticate("foobar")
  end
end
