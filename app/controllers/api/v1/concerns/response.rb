# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module Response # rubocop:disable Style/Documentation
        def json_response(object, status = :ok)
          render json: object, status: status
        end
      end
    end
  end
end
