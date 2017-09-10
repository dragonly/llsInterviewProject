class CreateRedPackets < ActiveRecord::Migration[5.0]
  def change
    create_table :red_packets do |t|
      t.string :token, :limit => 8, :null => false, index: true, unique: true
      t.integer :amount
      t.integer :quantity
      t.boolean :expired
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
