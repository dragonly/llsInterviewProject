class RedPacketCleanUpJob < ApplicationJob
  queue_as :default

  def perform(red_packet)
    red_packet.expired = true
    red_packet.save
  end
end
