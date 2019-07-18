# frozen_string_literal: true

# We also have a singleton Message to house all our messages;
# this an easier way to manage our application messages.
class Message
  class << self
    def invalid_credentials
      'Invalid credentials'
    end
  end
end
