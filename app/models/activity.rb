# frozen_string_literal: true

class Activity < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :contact

  validates :description, :contact, presence: true
end
