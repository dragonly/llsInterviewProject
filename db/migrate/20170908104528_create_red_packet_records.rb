class CreateRedPacketRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :red_packet_records do |t|
      t.integer :amount
      t.belongs_to :user, index: true
      t.belongs_to :red_packet, index: true

      t.timestamps
    end
  end
end
