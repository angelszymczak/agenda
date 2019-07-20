# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationController < ApiController # rubocop:disable Style/Documentation
        skip_before_action :authorize, only: :create

        def create
          user = User.create!(user_params)
          token = AuthenticateUser.new(user.email, user.password).call

          json_response({ message: Message.account_created, token: token }, :created)
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
