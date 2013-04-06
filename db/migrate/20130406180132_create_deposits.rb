class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.integer :user_id
      t.integer :club_id
      t.decimal :amount
      t.date :date
      t.timestamps
    end
  end
end
