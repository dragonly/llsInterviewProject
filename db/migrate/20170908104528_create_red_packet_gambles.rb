class CreateRedPacketGambles < ActiveRecord::Migration[5.0]
  def change
    create_table :red_packet_gambles do |t|
      t.integer :amount
      t.belongs_to :users, index: true
      t.belongs_to :red_packets, index: true

      t.timestamps
    end
  end
end
