class User < ActiveRecord::Base
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
	has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :tweets, dependent: :destroy
  # お気に入り
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet
  # フォローしている
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships

  # フォローされている
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def set_image(file)
    file_name = file.original_filename
    File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
    self.image = file_name
  end

  def feed
    Tweet.from_users_followed_by(self)
  end

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def favorite?(tweet)
    favorites.find_by(tweet_id: tweet.id)
  end

  def favorite!(tweet)
    favorites.create!(tweet_id: tweet.id)
  end

  def unfavorite!(tweet)
    favorites.find_by(tweet_id: tweet.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end