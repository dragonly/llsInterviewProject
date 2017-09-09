require 'test_helper'

class RedPacketControllerTest < ActionDispatch::IntegrationTest
  test "generate money for one red packet gamble" do
    controller = RedPacketController.new
    a = []
    total = left = 1000
    n = 5
    for i in 0..n-1 do
      money = controller.gen_random_money(left, n - i)
      left -= money
      a.append(money)
    end
    assert_equal total, a.sum
  end
end
