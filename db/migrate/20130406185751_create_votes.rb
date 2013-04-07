class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :request_id
      t.integer :user_id
      t.integer :club_id
      t.boolean :value

      t.timestamps
    end
  end
end
