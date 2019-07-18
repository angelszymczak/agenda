# frozen_string_literal: true

module Api
  module V1
    module Concerns
      # Errors responder
      module ExceptionHandler
        extend ActiveSupport::Concern

        class AuthenticationError < StandardError; end
        class MissingToken < StandardError; end
        class InvalidToken < StandardError; end

        included do
          rescue_from Exception, with: :internal_error

          rescue_from ActiveRecord::RecordNotFound, with: :not_found
          rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

          rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
          rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
          rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity
        end

        private

        def unprocessable_entity(errors)
          json_response({ errors: errors.message }, :unprocessable_entity)
        end

        def not_found(errors)
          json_response({ errors: errors.message }, :not_found)
        end

        def internal_error(errors)
          json_response({ errors: errors.message }, :internal_error)
        end

        def unauthorized_request(errors)
          json_response({ errors: errors.message }, :unauthorized_request)
        end
      end
    end
  end
end
