require 'test_helper'

class RedPacketIntegrationTest < ActionDispatch::IntegrationTest
  test "require logged in to call red_packet apis" do
    get red_packet_balance_path
    response_json = JSON.parse(response.body)
    assert_equal "login required", response_json["error"]
  end

  test "issue and get red packet" do
    # issue a red packet as user1
    log_in("user1", "password1")
    post red_packet_issue_path, params: {
      amount: 10000,
      quantity: 2 
    }
    response_json = JSON.parse(response.body)
    assert_equal 10000, response_json["amount"]
    assert_equal 1, RedPacket.count
    red_packet = RedPacket.first
    assert_equal 10000, red_packet.amount
    assert_equal 2, red_packet.quantity
    assert_equal current_user.id, red_packet.user_id

    # get a red packet as user2
    log_in("user2", "password2")
    post red_packet_gamble_path, params: {
      token: red_packet.token
    }
    assert_equal 1, RedPacketRecord.count
    record1 = RedPacketRecord.first
    assert_equal current_user.id, record1.user_id
    assert_equal red_packet.id, record1.red_packet_id
    balance1 = current_user.balance
    assert_equal record1.amount, balance1.amount

    # get a red packet as user1
    log_in("user1", "password1")
    post red_packet_gamble_path, params: {
      token: red_packet.token
    }
    assert_equal 2, RedPacketRecord.count
    record2 = RedPacketRecord.last
    assert_equal current_user.id, record2.user_id
    assert_equal red_packet.id, record2.red_packet_id
    balance2 = current_user.balance
    assert_equal record2.amount, balance2.amount

    # now red packet 1 is used up
    assert_equal 10000, record1.amount + record2.amount

    # test error conditions
    post red_packet_gamble_path, params: {
      token: red_packet.token
    }
    response_json = JSON.parse(response.body)
    assert_equal "red packet #{red_packet.token} spent up", response_json["error"]

    post red_packet_gamble_path, params: {
      token: "fake_token"
    }
    response_json = JSON.parse(response.body)
    assert_equal "no suck red packet with token fake_token", response_json["error"]
  end

  test "double aquire same red packet" do
    log_in("user1", "password1")
    post red_packet_issue_path, params: {
      amount: 10000,
      quantity: 2 
    }
    red_packet = RedPacket.first
    post red_packet_gamble_path, params: {
      token: red_packet.token
    }
    assert_equal 1, RedPacketRecord.count
    post red_packet_gamble_path, params: {
      token: red_packet.token
    }
    response_json = JSON.parse(response.body)
    assert_equal "you've already got a red packet with token #{red_packet.token}", response_json["error"]
    assert_equal 1, RedPacketRecord.count
  end

  test "list red packet records and balance" do
    log_in("user1", "password1")
    post red_packet_issue_path, params: {
      amount: 10000,
      quantity: 2 
    }
    red_packet = RedPacket.first
    post red_packet_gamble_path, params: {
      token: red_packet.token
    }
    # list
    get red_packet_list_path
    response_json = JSON.parse(response.body)
    assert_equal 1, response_json.length
    # balance
    get red_packet_balance_path
    response_json = JSON.parse(response.body)
    record = RedPacketRecord.first
    assert_equal record.amount, response_json["amount"]
  end

  test "expired red packet" do
    # TODO
  end
end
