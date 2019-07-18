# frozen_string_literal: true

# JWT Handler
class JsonWebToken
  class << self
    def encode(payload, exp = expiration_date)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_key)
    end

    private

    def expiration_date
      Rails.application.credentials[Rails.env.to_sym][:jwt][:expiration].hours.from_now
    end

    def secret_key
      Rails.application.credentials[Rails.env.to_sym][:jwt][:key]
    end
  end
end
