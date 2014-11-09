class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :comment
      t.integer :user_id
      t.timestamps
    end
  end
end
