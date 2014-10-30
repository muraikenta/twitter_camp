class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :tweet_id
    add_index :favorites, [:user_id, :tweet_id], unique: true
  end
end
