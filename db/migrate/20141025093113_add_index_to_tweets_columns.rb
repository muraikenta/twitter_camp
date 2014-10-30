class AddIndexToTweetsColumns < ActiveRecord::Migration
  def change
  	add_index :tweets, [:user_id, :created_at]
  end
end
