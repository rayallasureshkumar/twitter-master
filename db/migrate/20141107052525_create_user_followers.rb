class CreateUserFollowers < ActiveRecord::Migration
  def change
    create_table :user_followers do |t|
      t.integer :user_id
      t.integer :follower_id
      
      t.timestamps
    end
  end
end
