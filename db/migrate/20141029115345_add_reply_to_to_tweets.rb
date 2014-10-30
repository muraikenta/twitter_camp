class AddReplyToToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :reply_to, :string
  end
end
