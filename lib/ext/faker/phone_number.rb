# frozen_string_literal: true

module Faker
  # Monkeypatch:
  #   Faker generates the number with the correct structures,
  #   but they are not valid according to the google library
  #   which we use to validate telephone numbers.
  class PhoneNumber
    def self.valid_cell_phone
      loop do
        phone = Faker::PhoneNumber.cell_phone
        break phone if TelephoneNumber.valid?(phone, :us, %i[mobile])
      end
    end
  end
end
