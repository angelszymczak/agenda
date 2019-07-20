# frozen_string_literal: true

# We also have a singleton Message to house all our messages;
# this an easier way to manage our application messages.
class Message
  class << self
    def account_created
      'Account created successfully'
    end

    def invalid_credentials
      'Invalid credentials'
    end

    def invalid_token
      'Invalid token'
    end

    def missing_token
      'Missing token'
    end

    def not_found(record = 'record')
      "Sorry, #{record} not found."
    end

    def unauthorized
      'Unauthorized request'
    end
  end
end
