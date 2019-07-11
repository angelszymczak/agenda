# frozen_string_literal: true

class Contact < ApplicationRecord # rubocop:disable Style/Documentation
  validates :first_name, :last_name, :cell_phone, :zip_code, presence: true

  validates :cell_phone, telephone_number: { country: :us, types: %i[mobile] }
end
