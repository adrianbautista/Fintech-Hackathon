class AddMessagetoRequest < ActiveRecord::Migration
  def up
    add_column :requests, :message, :string
    add_column :requests, :status, :string
  end

  def down
    remove_column :requests, :message
    remove_column :requests, :status
  end
end
