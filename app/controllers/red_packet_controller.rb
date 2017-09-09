class RedPacketController < ApplicationController
  before_action :require_logged_in
  def issue
    params.require(:amount)
    params.require(:quantity)
    amount = params[:amount]
    quantity = params[:quantity]
    token = gen_token
    red_packet = RedPacket.new(token: token, amount: amount, quantity: quantity, user_id: current_user.id)
    red_packet.save
    if !red_packet.errors.nil?
      render :json => red_packet
    else
      render :json => red_packet.errors.full_messages
    end
  end

  def gamble
    params.require(:token)
    token = params[:token]
    red_packet = RedPacket.find_by(token: token)
    if red_packet.nil?
      render :json => { :error => "no suck red packet with token #{token}" }
      return
    end
    if red_packet.quantity == red_packet.red_packet_records.count
      render :json => { :error => "red packet #{token} spent up" }
      return
    end
    if red_packet.red_packet_records.map{|record| record.user_id}.include?(current_user.id)
      render :json => { :error => "you've already got a red packet with token #{token}" }
      return
    end
    amount = -1
    ActiveRecord::Base.transaction do
      amount_total = red_packet.amount
      amount_spent = red_packet.red_packet_records
                       .map{|record| record.amount}
                       .reduce(:+)
      if amount_spent.nil?
        amount_spent = 0
      end
      amount_left = amount_total - amount_spent
      quantity_left = red_packet.quantity - red_packet.red_packet_records.count
      amount = gen_random_money(amount_left, quantity_left)
      current_user.balance.amount += amount
      current_user.balance.save
      current_user.red_packet_records.create(amount: amount, red_packet_id: red_packet.id)
    end
    render :json => {
      :amount => amount
    }
  end

  def list
    records = current_user.red_packet_records
    render :json => records
  end

  def balance
    amount = current_user.balance.amount
    render :json => {
      :amount => amount
    }
  end


  def gen_token
    token = SecureRandom.base58(8)
    red_packet = RedPacket.find_by(token: token)
    while !red_packet.nil? do
      token = SecureRandom.base58(8)
      red_packet = RedPacket.find_by(token: token)
    end
    token
  end
  def gen_random_money(amount, quantity)
    if quantity == 1
      return amount
    end
    rng = Random.new
    min = 1
    max = amount / quantity * 2
    money = rng.rand(max)
    [money, min].max
  end
end
