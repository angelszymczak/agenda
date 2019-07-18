# frozen_string_literal: true

# Private Request Handler
class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id)
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user.present? && user.authenticate(password)

    raise Api::V1::Concerns::ExceptionHandler::AuthenticationError, Message.invalid_credentials
  end
end
