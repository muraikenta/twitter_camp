json.array!(@tweets) do |tweet|
  json.extract! tweet, :content, :user_id
  json.url tweet_url(tweet, format: :json)
end