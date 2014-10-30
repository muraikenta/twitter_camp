class AddIndexToUsersColumns < ActiveRecord::Migration
  def change
    add_index :microposts, [:user_id, :created_at]
  end
end
