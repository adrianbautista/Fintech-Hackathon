class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.date :date
      t.decimal :price
      t.float :quantity
      t.string :symbol
      t.integer :user_id
      t.integer :club_id
      t.timestamps
    end
  end
end
