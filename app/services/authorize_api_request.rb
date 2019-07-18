# frozen_string_literal: true

# Private Request Handler
class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers)
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token.present?
  rescue ActiveRecord::RecordNotFound => e
    raise Api::V1::Concerns::ExceptionHandler::InvalidToken, "#{Message.invalid_token} #{e.message}"
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    raise Api::V1::Concerns::ExceptionHandler::MissingToken, Message.missing_token
  end
end
