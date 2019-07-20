# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationController < ApiController # rubocop:disable Style/Documentation
        skip_before_action :authorize, only: :create

        def create
          json_response({ message: Message.account_created, token: token }, :created)
        end

        private

        def registration_params
          params.require(:registration).permit(:email, :password, :password_confirmation)
        end

        def token
          @token ||= AuthenticateUser.new(user.email, user.password).call.result
        end

        def user
          @user ||= User.create!(registration_params)
        end
      end
    end
  end
end
