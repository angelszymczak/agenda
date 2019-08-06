# frozen_string_literal: true

class AdminUser < ApplicationRecord # rubocop:disable Style/Documentation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
