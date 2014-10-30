class AboutController < ApplicationController
  def index
  	if signed_in?
  		@title = 'Tweet'
  		@tweet = current_user.tweets.build
  		@feed_tweets = current_user.feed.paginate(page: params[:page])
  	end
  end
end
