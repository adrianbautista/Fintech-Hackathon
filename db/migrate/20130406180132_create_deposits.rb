class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.decimal :amount
      t.date :date
      #t.integer :user_id
      #t.integer :club_id
      t.timestamps
    end
  end
end
