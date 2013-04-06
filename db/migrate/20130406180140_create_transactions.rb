class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :price
      t.float :quantity
      t.string :symbol
      t.date :date
      t.timestamps
    end
  end
end
