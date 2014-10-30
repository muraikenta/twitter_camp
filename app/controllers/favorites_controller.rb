class FavoritesController < ApplicationController
  before_action :signed_in_user

  def create
    @tweet = Tweet.find(params[:tweet_id])
    current_user.favorite!(@tweet)
  end

  def destroy
    @tweet = Favorite.find(params[:id]).tweet
    current_user.unfavorite!(@tweet)
  end
end
