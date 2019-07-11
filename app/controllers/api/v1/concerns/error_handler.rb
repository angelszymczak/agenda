# frozen_string_literal: true

# Errors handlers
module Api::V1::Concerns
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from Exception do |e|
        json_response({ error: e.message }, :internal_error)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({ error: e.message }, :not_found)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        json_response({ error: e.message }, :unprocessable_entity)
      end
    end
  end
end
