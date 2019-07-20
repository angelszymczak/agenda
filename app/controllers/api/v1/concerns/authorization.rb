module Api
  module V1
    module Concerns
      module Authorization
        extend ActiveSupport::Concern

        included do
          before_action :authorize
        end

        private

        def authorize
          return if (Current.user = AuthorizeApiRequest.call(request.headers).result).present?

          raise AuthenticationError, Message.unauthorized
        end
      end
    end
  end
end
