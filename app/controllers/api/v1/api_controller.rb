# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API # rubocop:disable Style/Documentation
      include Concerns::Response
      include Concerns::ExceptionHandler
    end
  end
end
