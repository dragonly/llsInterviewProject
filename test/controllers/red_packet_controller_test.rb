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

  test "expired red packet" do
    red_packet = RedPacket.create(token: "12345678", amount: 233, quantity: 233, expired: false, user_id: 1)
    assert_equal false, red_packet.expired
    RedPacketCleanUpJob.perform_now(red_packet)
    red_packet = RedPacket.first
    assert_equal true, red_packet.expired
  end
end
