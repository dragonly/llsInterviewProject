class CreateRedPackets < ActiveRecord::Migration[5.0]
  def change
    create_table :red_packets do |t|
      t.string :token, :limit => 8, :null => false
      t.integer :amount
      t.belongs_to :users, index: true

      t.timestamps
    end
  end
end
