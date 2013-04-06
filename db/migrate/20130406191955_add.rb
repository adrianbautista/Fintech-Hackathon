class Add < ActiveRecord::Migration
  def change
    add_column :transactions, :request_id, :integer
  end
end
