# frozen_string_literal: true

class ApiVersion # rubocop:disable Style/Documentation
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  # check version from Accept headers; expect media type `api`
  def check_headers(headers)
    headers[:accept].try(:include?, "application/vnd.api.#{version}+json")
  end
end
