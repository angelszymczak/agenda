# frozen_string_literal: true

module Api
  module V1
    module Auth
      class AuthenticationController < ApiController # rubocop:disable Style/Documentation
        skip_before_action :authorize, only: :create

        def create
          json_response(token: token)
        end

        private

        def authentication_params
          params.require(:authentication).permit(:email, :password)
        end

        def token
          AuthenticateUser.call(authentication_params[:email], authentication_params[:password]).result
        end
      end
    end
  end
end
