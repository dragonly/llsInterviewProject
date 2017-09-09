class CreateBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :balances do |t|
      t.integer :amount
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
