# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes # rubocop:disable Style/Documentation
  attribute :user, :request_id, :user_agent, :ip_address
end
