# frozen_string_literal: true

module ControllerSpecHelper # rubocop:disable Style/Documentation
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers
    {
      'Authorization' => token_generator(create(:user).id),
      'Content-Type' => 'application/json'
    }
  end
end
