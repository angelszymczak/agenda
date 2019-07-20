# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  has_secure_password

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
end
