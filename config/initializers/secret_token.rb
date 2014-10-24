# Twitter::Application.config.secret_key_base = '795548644c62f68c9336846061e2aae61330d9dd207367898f34f75de31da959c11b93e4e8ce7a1980452ad2056a6b68628857423cbacccc1dce39a87fb6e7a2'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Twitter::Application.config.secret_key_base = secure_token