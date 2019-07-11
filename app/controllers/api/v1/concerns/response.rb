# frozen_string_literal: true

# Json render helper
module Api::V1::Concerns
  module Response
    def json_response(object, status = :ok)
      render json: object, status: status
    end
  end
end
